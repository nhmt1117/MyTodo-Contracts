# 运营扩展接口（兼容新增）

已有客户端无需升级即可继续同步。新增 `POST /api/v1/feedback`，需要访问令牌，接收 `content`（1–2000 字）、`category`（BUG、SUGGESTION、OTHER）、`appVersion`（最多 40 字）。平台和用户身份由已验证设备决定，不接受客户端指定用户。每分钟最多 3 次。响应只有 id、status、createdAt，不返回运营内部备注。客户端提交入口尚待接入。

后台的会员方案为草稿目录，不影响现有 `/membership/me`、免费额度或可购买套餐。没有支付或权益执行前不允许发布售卖。

## 方案与收款登记

方案增加 kind（FREE/MEMBER）、五平台同时登录设备额度（各 1–20）、cloudSyncEnabled、cloudPushEnabled 和 historyRetentionDays（1–3650）。普通用户方案由迁移唯一初始化，价格和周期均为 0，不可归档或转换类型；仍为配置草稿，不改变运行中的免费限制。旧修改请求省略新字段时保持现值。

`GET|POST /admin/billing-records` 查询或人工登记 RECHARGE/PURCHASE；必须提供用户、人民币分金额、来源凭证 reference、原因、幂等 requestId。购买还必须提供方案 id/revision。服务端保存不可变方案快照；充值不产生钱包余额，购买产生待开通会员记录，不触发真实支付、自动续费或权益下发。

`POST /admin/billing-records/:id/void` 以版本号和原因作废误录记录，保留原金额及快照，不执行退款。`GET /admin/users/:id/membership-records` 返回当前实际 free 会员及待开通/已作废的购买记录。金额、状态不能直接覆盖，管理操作全部审计；查询支持分页、用户、类型、状态。

## 账户管控与反馈细分（2026-09-27）

后台新增冻结、解冻和撤销全部设备。冻结同时撤销设备与推送凭据，不删除本地或云端待办；解冻不恢复旧令牌。登录、恢复密钥及配对建会话会校验账户状态，冻结账户返回 403、`code=ACCOUNT_SUSPENDED`；旧访问/刷新令牌仍返回兼容的 401。客户端不得据此清空本地任务。仅支持操作非管理员账户，必须填写原因并携带管理版本号。

管理员用户响应增加 suspendedAt、suspensionReason、adminRevision。反馈管理增加 priority（LOW、NORMAL、HIGH），老请求不提供 priority 时保持原值；用户提交接口不接受管理员字段。处理记录只对管理员开放。新增 `/admin/audit/search` 分页查询接口，原 `/admin/audit` 的数组结构不变。

日活定义为北京时间自然日内经鉴权访问用户 API 的去重非管理员账户，包含后台同步，并非前台使用时长。近期在线为近 5 分钟访问过用户 API、未撤销且刷新凭据未过期的设备；按平台分别统计设备与去重用户。管理员后台访问不计入。未采集日期返回 null，不补造历史日活。注册数按账户创建时间统计。
