# MyTodo Contracts

MyTodo 多端共享协议仓库。这里保存服务端接口快照、跨端数据结构、提醒规则和同步测试样例，不包含任何客户端业务实现。

## 目录

- `openapi/mytodo-api.json`：由运行中的 MyTodo Server `/docs-json` 导出的接口快照。
- `schemas/`：OpenAPI 之外仍需各端共同遵守的数据结构。
- `config/reminder-profiles.json`：提醒方案和自动推荐映射。
- `config/free-limits.json`：免费版待办数量与同平台设备数量上限。
- `fixtures/`：用于验证不同客户端行为一致性的固定样例。
- `docs/`：兼容性、错误处理和协议演进说明。
- `scripts/check.ps1`：无需额外依赖的快速校验入口。

## 使用规则

涉及跨端字段或行为的改动按以下顺序进行：

1. 先修改本仓库并增加对应样例。
2. 修改服务端并重新导出 OpenAPI。
3. 更新 Windows、Android 及其他客户端。
4. 各端使用同一组 fixtures 验证结果。

目前提醒、同步与完整任务字段样例会同步到各端的 `test/contracts/`，使单仓库检查不依赖相邻仓库；本机存在 MyTodo-Contracts 时，各端测试还会核对副本与源样例一致。同步样例中的“未上传的新任务本地删除”由客户端测试验证，不会发送到服务端。

执行检查：

```powershell
.\scripts\check.ps1
```

服务端运行时重新导出 OpenAPI：

```powershell
.\scripts\export-openapi.ps1
```

跨仓开发顺序见 [ROADMAP.md](ROADMAP.md) 和 [统一开发流程](docs/DEVELOPMENT_WORKFLOW.md)。

当前协议版本见 `config/reminder-profiles.json` 和各 Schema 的 `$id`。在正式自动生成客户端代码前，OpenAPI 文件作为接口清单使用，业务约束以 `schemas/` 与 `docs/` 为准。
