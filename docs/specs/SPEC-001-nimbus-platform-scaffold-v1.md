# SPEC-001 Nimbus Framework脚手架 v1

> Status: verified  
> Number: SPEC-001  
> Priority: P0  
> Version: 2026-07-17

## 1. 背景与问题

需要一套可重复用于不同 App 与运营后台项目的 Java 平台脚手架，在保留领域边界的同时避免首期微服务运维复杂度。

## 2. 当前证据

- 目标目录在任务开始时为空。
- 参考底座是 JDK 25、Spring Boot 4.1、Vue 3、Vite 8 的模块化单体。
- 上游完整工程包含大量当前不需要的 CRM、ERP、Mall、IoT、AI 等模块。
- 参考工程默认使用 MySQL，业务扩展模块缺少可直接用于本项目的完整 PostgreSQL 生产 SQL。
- AI Harness 基线采用 Rule / Spec / Skill 与 Think -> Spec -> Plan -> Build -> Review -> Test/QA -> Ship -> Reflect。

## 3. 框架目标

1. 只保留 System、Infra、Member、Pay。
2. Java 根包改为 `com.nimbus`。
3. 新建 Application、IM、App 三个空模板模块；App 作为集成应用可调用其他模块。
4. 植入 AI Harness 规范。
5. README 说明 Nimbus Framework、开发和启动方式。
6. 重设计管理后台并移除上游项目可见品牌。
7. PostgreSQL 作为默认数据库基线，同时保留 MySQL 8.4 适配。
8. 框架目录可独立构建、测试并作为新项目模板复制。

## 4. 非目标

- 本期不实现 Application、IM、App 的具体业务。
- 本期不迁移现有 Go 业务数据。
- 本期不部署 Nacos、Gateway、Seata 或拆分多 JVM 微服务。

## 5. 目标体验

- 开发者通过 Docker 启动 PostgreSQL、Redis，执行标准命令即可启动后端和管理前端。
- UI 只呈现 Nimbus Framework 默认品牌和已保留模块。
- 新业务从模板模块复制边界即可开始编写 Spec 和测试。

## 6. 技术设计

- 后端：JDK 25 + Spring Boot 4.1 模块化单体。
- 前端：Vue 3 + Element Plus + Vite 8。
- 数据：PostgreSQL（默认）/ MySQL 8.4（兼容）+ Redis。
- 模块边界：System、Infra、Member、Pay、Application、IM、App。
- App 依赖其他模块公开契约；其他模块禁止依赖 App。

## 7. 数据结构

- System、Infra 使用仓库内 PostgreSQL 基础 SQL。
- Member、Pay 的生产表结构必须随模块提供 PostgreSQL 迁移，不允许运行时自动建表。
- 三个模板模块不创建业务表。

## 8. 接口契约

- 管理接口：`/admin-api/**`。
- APP 接口：`/app-api/**`。
- 模板模块不提供 Controller 或业务实现，只声明包结构与依赖方向。

## 9. 状态机

脚手架交付状态：`initialized -> building -> tested -> copied -> verified`。

## 10. 错误处理

- PostgreSQL 或 Redis 不可用时启动失败并输出明确依赖错误。
- 数据库类型必须显式配置，禁止运行时静默切换。
- 模板接口不得返回伪造业务成功结果，只表达模块可达性。

## 11. 验收标准

- Maven Reactor 只包含指定模块及框架组件。
- Java 主源码不存在旧根包声明。
- 后端测试与打包通过。
- 前端类型检查、Lint 或构建通过，浏览器可正常访问。
- PostgreSQL 初始化及核心登录成功，MySQL 驱动、脚本与配置切换入口齐全。
- README、AGENTS、Rule/Spec/Skill 索引齐全。
- UI、README、应用标题和 Banner 无上游品牌。
- `nimbus-framework` 可独立构建，且不包含特定业务项目描述。

## 12. 测试计划

- `mvn test` 与 `mvn package`。
- PostgreSQL/Redis 容器初始化与后端健康检查。
- 前端类型检查、Lint、构建。
- 登录页与首页浏览器验收。
- `rg` 扫描包名、模块、品牌和数据库配置。
- Nimbus 后端与前端独立构建检查。

## 13. 迁移与兼容

- 新脚手架不直接复用现有 MySQL 数据；后续单独编写迁移 Spec。
- 保留第三方许可证，移除的只是产品可见品牌与营销入口。
- 首期单体边界要允许未来按模块拆分，但不提前引入分布式事务。

## 14. 验证记录

- 2026-07-17：JDK 25 下 26 个 Maven Reactor 模块完整测试及打包通过。
- 2026-07-17：前端类型检查、Lint 与生产构建通过。
- 2026-07-17：PostgreSQL 17 与 MySQL 8.4 均完成独立初始化，分别得到 60/59 张表，并验证管理员与四个核心菜单。
- 2026-07-17：根包统一为 `com.nimbus.*`；包名、模块名、SQL、前端与产品文档完成品牌独立化扫描。
