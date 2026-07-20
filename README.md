# Nimbus Framework

> 四套 Nimbus 框架的版本导航与选型说明：[GitHub Pages](https://lohasle.github.io/nimbus-framework/)

Nimbus Framework 是可复用于新项目的 Java 平台工程底座，适合创业团队快速搭建 App API 与运营后台。默认采用模块化单体：在一个 JVM 内保留清晰的领域边界，控制首期部署和排障成本，同时为未来按模块拆成微服务预留 API 与依赖方向。

## 技术基线

| 层次 | 版本 / 方案 |
| --- | --- |
| Java | JDK 25 |
| Java 根包 | `com.nimbus.*` |
| 后端 | Spring Boot 4.1、MyBatis-Plus |
| 前端 | Vue 3.5、Vite 8、TypeScript 6、Element Plus 2.13 |
| 数据 | MySQL 8.4（默认）、PostgreSQL 17（兼容）、Redis 7.4 |
| 可观测性 | Actuator、Prometheus、Micrometer Tracing、OpenTelemetry |

## 模块边界

| 模块 | 类型 | 说明 |
| --- | --- | --- |
| `nimbus-module-system` | 核心 | 账号、组织、角色、权限、租户和审计 |
| `nimbus-module-infra` | 核心 | 配置、任务、文件、日志与平台基础能力 |
| `nimbus-module-member` | 核心 | App 会员、等级、积分和画像 |
| `nimbus-module-pay` | 核心 | 支付应用、渠道、订单、退款和钱包 |
| `nimbus-module-application` | 空模板 | 应用注册、版本和渠道扩展边界 |
| `nimbus-module-im` | 空模板 | 会话、消息和推送扩展边界 |
| `nimbus-module-app` | 空模板 | App 跨领域用例的集成编排层 |

三个模板模块只声明边界与依赖，不包含业务实现。`nimbus-module-app` 可以依赖各领域公开 API，各领域模块不得反向依赖 App 集成层。

## 快速启动

```bash
# 1. 启动 MySQL 8.4 与 Redis（首次启动自动初始化表结构）
docker compose up -d

# 2. 启动后端
./scripts/build-local.sh
./scripts/run-local.sh

# 3. 新终端启动前端
cd frontend
pnpm install
pnpm dev
```

- 运营后台：<http://localhost:3001>
- 后端 API：<http://localhost:58080>
- Swagger：<http://localhost:58080/swagger-ui>
- 健康检查：<http://localhost:58080/actuator/health>
- Prometheus：<http://localhost:58080/actuator/prometheus>
- 本地账号：`admin / admin123`（仅限开发环境，上线前必须替换）

完整说明见 [本地开发与启动](docs/local-development.md)、[部署与可观测性](docs/deployment.md) 和 [架构边界](docs/architecture.md)。AI 协作入口见 [AGENTS.md](AGENTS.md) 与 [工程文档索引](docs/README.md)。

MySQL 8.4 是默认与主验收数据库；PostgreSQL 适配仍完整保留。切换方式见 [数据库适配](docs/database-adapters.md)。

## 质量门禁

```bash
cd backend && mvn test && mvn package
cd frontend && pnpm ts:check && pnpm lint && pnpm build:local
```

涉及接口、数据结构或模块边界的变更，先更新 `docs/specs/`，再实施和测试。

## 许可证

本项目保留所基于开源组件的许可证与著作权声明。默认产品界面使用 Nimbus 品牌，新项目可替换；第三方归属见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。
