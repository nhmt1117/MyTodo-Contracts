# 会员方案与版本

- 管理端保存草稿不改变用户权益；发布生成不可变版本，重复发布同一草稿版本幂等。
- 已发布且上架的方案通过 `GET /membership/plans` 展示。下架不影响已有会员。
- 普通用户自动采用最新发布的 FREE 方案；尚未发布时使用 100 条未完成、500 条已完成、每平台 1 台的默认值。
- 会员绑定购买或赠送时的版本，到期退回普通方案；降低额度不批量删除数据。新建/恢复受额度约束，每次完成最多替换一条最早完成记录。
- 正式支付仍未开放；管理员赠送开通必须填写原因和请求幂等 ID。充值/购买人工登记不等于支付成功，不自动开通。公开目录当前仍返回 `purchasable=false`。
- 支付订单使用服务端发布版本锁价，订单有独立的 `PENDING/PAID/PAID_NEEDS_REVIEW/CANCELLED/EXPIRED` 状态；订单请求 ID 保证幂等。仅已核实支付的订单可生成会员赠予，人工台账不能代替支付凭证。
- `GET /membership/checkout-config` 说明支付模式。默认 `disabled`；`sandbox` 仅允许非生产环境的 `@example.com` 测试账户模拟完成订单，绝不作为真实支付。正式收款需另接支付服务商、验证回调签名和金额、处理退款与对账。
- `/membership/me` 保留原字段，增加 `plan.versionId`、`limitsByPlatform`、`baseLimits`。额度由服务端裁决；客户端缓存权益用于离线体验，到期使用普通方案额度。
- 已有会员草稿修改、发布须确认影响人数；修改付费方案仅影响未来新开通，不追溯已有版本。
- 同方案续期接在已有有效期之后，跨方案切换暂不开放，避免覆盖未消费权益。
- `cloudPushEnabled` 未实现，不允许发布开启该能力的方案；历史保留天数暂为预留配置，不作为已实现权益销售。

管理接口：`POST /admin/plans/:id/publish`（revision、listed、acknowledgeMembers）；`POST /admin/plans/:id/listing`（revision、listed）；`POST /admin/users/:id/membership-grants`（versionId、requestId、reason）。
