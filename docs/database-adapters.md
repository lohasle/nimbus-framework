# 数据库适配

Nimbus Framework 默认使用 MySQL 8.4，同时保留 PostgreSQL 17 适配。两个 JDBC 驱动均随后端打包，业务代码不得依赖某一数据库的隐式行为。

## MySQL 8.4（默认）

根目录执行 `docker compose up -d` 即会启动 MySQL 8.4，并使用端口 `23306` 自动执行以下初始化脚本：

1. `backend/sql/mysql/nimbus-platform.sql`
2. `backend/sql/mysql/quartz.sql`
3. `backend/sql/mysql/member.sql`
4. `backend/sql/mysql/nimbus-customize.sql`

本地配置默认值如下，无需额外设置：

```bash
export NIMBUS_DB_DRIVER=com.mysql.cj.jdbc.Driver
export NIMBUS_DB_URL='jdbc:mysql://127.0.0.1:23306/nimbus_platform?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Shanghai&nullCatalogMeansCurrent=true&rewriteBatchedStatements=true'
export NIMBUS_DB_USERNAME=nimbus
export NIMBUS_DB_PASSWORD=nimbus_dev
export NIMBUS_DB_SCHEMA=nimbus_platform
```

## PostgreSQL 17（可选）

```bash
export NIMBUS_DB_DRIVER=org.postgresql.Driver
export NIMBUS_DB_URL=jdbc:postgresql://127.0.0.1:25432/nimbus_platform
export NIMBUS_DB_USERNAME=nimbus
export NIMBUS_DB_PASSWORD=nimbus_dev
export NIMBUS_DB_SCHEMA=public
```

初始化脚本位于 `backend/sql/postgresql/`。先执行 `docker compose --profile postgres up -d postgres`，再使用上述环境变量覆盖本地默认数据源。

## 兼容规则

- 通用查询优先使用 MyBatis-Plus / Mapper API；数据库特有 SQL 分目录维护。
- 分页、布尔值、时间精度、JSON、递归查询与关键字必须在两种数据库分别验证。
- 新增表结构时，PG 与 MySQL 脚本必须在同一个 Spec 中同步提交。
- MySQL 8.4 是默认 CI 与生产建议基线；启用 PostgreSQL 时需增加对应的真实数据库集成测试。
