# 统一开发流程

## 开始任务

1. 阅读本仓库 `ROADMAP.md`。
2. 阅读目标仓库的 `PROJECT_STATUS.md`、`ARCHITECTURE.md` 和 `KNOWN_ISSUES.md`。
3. 列出准备修改、验证和明确不修改的内容，然后直接开始。

推荐需求格式：

```text
目标：
修改仓库：
允许修改范围：
期望行为：
不需要修改：
验证等级：quick / full / release
是否提交：否 / 是
```

## 验证等级

- quick：格式、静态检查和单元测试。
- full：quick 加完整开发构建或集成检查。
- release：full 加正式构建、成品校验和人工发布清单。

简单文案和样式默认 quick；同步、数据库、认证、提醒、安装和更新至少 full；正式发布使用 release。

## 结束任务

1. 更新目标仓库 `PROJECT_STATUS.md`。
2. 协议变化同步更新 Contracts、fixtures 和 OpenAPI。
3. 报告验证结果、未验证部分和已知风险。
4. 只有用户明确要求时才提交、打 tag 或推送。
