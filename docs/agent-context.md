# Agent Context

## 项目定位

Nimbus Framework 是可复制到不同业务项目的 Java 平台底座，覆盖 App API 与运营后台，并保持未来拆分微服务的边界。

## 当前模块

- 平台底座：System、Infra
- 通用业务：Member、Pay
- 空模板：Application、IM、App
- 管理前端：Vue 3 + Element Plus
- 数据库：MySQL 8.4（默认）、PostgreSQL 17（兼容）

## 关键约束

- `nimbus-module-app` 负责集成编排，不拥有其他领域的核心数据。
- Application、IM 与 App 当前只提供模块结构和依赖边界，不提供业务实现或占位接口。
- 任何来自上游脚手架的可见品牌不得出现在 UI、README、应用标题和启动 Banner 中。
- 第三方许可证必须保留在 `LICENSE` 或 `THIRD_PARTY_NOTICES.md`，不得因去品牌而删除法定声明。
