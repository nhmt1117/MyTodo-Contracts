# 项目状态

更新日期：2026-09-19

## 已完成

- 从 MyTodo Server 导出 OpenAPI 0.1.0 基线。
- 定义完整 Todo、同步 payload、mutation、账户和会员 Schema。
- 固化提醒方案、自动优先级映射和循环任务裁剪规则。
- 增加提醒与同步一致性 fixtures。
- 增加兼容性、错误码、路线图和统一开发流程。
- 增加 JSON 快速检查和 GitHub Actions。

## 下一步

1. 为服务端响应补齐 OpenAPI DTO 后重新导出。
2. 在 Windows、Android 测试中直接消费共享 fixtures。
3. 增加 OpenAPI 向后兼容差异检查。
4. 公网 API 确定后建立正式版本与发布记录。
