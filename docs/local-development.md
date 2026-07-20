# 本地开发与启动

## 环境要求

- JDK 25、Maven 3.9+
- Node.js 24、pnpm 11
- Docker Desktop / Docker Compose
- 建议至少 8 GB 内存、10 GB 可用磁盘

## 启动依赖

在仓库根目录执行：

```bash
docker compose up -d
docker compose ps
```

MySQL 8.4 映射到 `23306`，Redis 映射到 `26379`。首次创建数据卷时，Compose 会按顺序执行 `backend/sql/mysql/` 下的基础结构、Quartz 和 Nimbus 定制 SQL。PostgreSQL 仅在显式启用 `postgres` profile 时启动。

需要完全重置本地数据时才执行：

```bash
docker compose down -v
docker compose up -d
```

`down -v` 会永久删除本地数据库和 Redis 数据，请勿用于共享或生产环境。

## 启动后端

```bash
cd backend
export JAVA_HOME=/opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home
../scripts/build-local.sh
../scripts/run-local.sh
```

默认配置来自 `application.yaml` 与 `application-local.yaml`。数据库、Redis、支付回调、加密密钥等均可通过环境变量覆盖；生产环境不得使用仓库内开发密码或占位密钥。

## 启动前端

```bash
cd frontend
pnpm install
pnpm dev
```

打开 <http://localhost:3001>，开发账号为 `admin / admin123`。

## 常用验证

```bash
curl http://localhost:58080/actuator/health
curl http://localhost:58080/v3/api-docs

cd backend
mvn test

cd ../frontend
pnpm ts:check
pnpm lint
pnpm build:local
```

## 新业务开发

1. 在 `docs/specs/` 创建编号 Spec 并登记索引。
2. 明确所属领域；跨领域用例放在 `nimbus-module-app` 编排。
3. 先定义公开 API 与测试，再实现 Service 和 Mapper。
4. MySQL 与 PostgreSQL 表结构随模块提交，禁止依赖运行时自动建表。
5. 通过后端、前端与浏览器验收后再交付。
