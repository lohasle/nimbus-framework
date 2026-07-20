# SPEC-005 共享新 UI 与 MySQL 8.4 默认化 v1

> Status: implementing  
> Priority: P0  
> Approved: 2026-07-20

## 范围

本仓库是四套 Nimbus 产品矩阵中的 Java 模块化单体版。跨仓库完整规格以 `nimbus-cloud-framework/docs/specs/SPEC-009-four-frameworks-and-muse-go-v1.md` 为准。

本地交付范围：

1. 同步符合 `设计规范.md`、`login.png`、`admin.png` 的共享新 UI；
2. 保留现有路由、权限、接口和业务组件；
3. 默认数据库由 PostgreSQL 切换为 MySQL 8.4，继续保留 PostgreSQL 可选支持；
4. 后端编译、前端检查与构建通过；
5. MySQL 空库初始化、启动、登录和首页 smoke 验收通过；
6. 创建 `lohasle/nimbus-framework` 并由本仓库发布介绍四套框架的 GitHub Pages。

## 非目标

- 不进行全业务 E2E。
- 不新增效果图中的虚构业务模块和数据。
- 不重写成熟表格与表单逻辑。

## 验收

- [ ] 新 UI 与 Java Cloud 视觉一致且不变形；
- [ ] 默认 Compose 和本地配置使用 MySQL 8.4；
- [ ] Java、前端构建通过；
- [ ] MySQL 初始化、启动、登录、首页通过；
- [ ] main 分支发布，Pages 可访问。
