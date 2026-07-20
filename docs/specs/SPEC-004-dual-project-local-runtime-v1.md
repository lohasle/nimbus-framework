# SPEC-004 Nimbus 与暮色并行本地运行 v1

> Status: verified  
> Number: SPEC-004  
> Priority: P0  
> Version: 2026-07-18

## 1. 背景

Nimbus Framework 是个人可复用底座，继续采用单 JVM 模块化单体；暮色 APP 已切换为 Cloud 微服务。两套工程原先共用前端、后端、PostgreSQL 和 Redis 端口，无法同时启动和验收。

## 2. 目标

- 保持 Nimbus 既有单 JVM 架构和 System、Infra、Member、Pay、Application、IM、App 模块边界。
- 为 Nimbus 分配独立的本地端口、容器和数据卷，使其能与暮色微服务同时运行。
- 提供 JDK 25 构建、启动、停止和状态脚本。
- 验证 PostgreSQL、Redis、后端、前端、登录与会员管理链路。

## 3. 非目标

- 不把 Nimbus 改造成微服务。
- 不新增业务实体、数据表、菜单或页面。
- 不修改现有运营后台表格、表单、标签页和布局样式。

## 4. 本地端口

| 组件 | Nimbus | 暮色 |
| --- | ---: | ---: |
| 运营后台 | 3001 | 3000 |
| 后端入口 | 58080 | 48080 |
| PostgreSQL | 25432 | 15432 |
| Redis | 26379 | 16379 |
| MySQL 可选 | 23306 | 13306 |

## 5. 验收标准

- Nimbus Maven 和前端质量门禁通过。
- Nimbus PostgreSQL、Redis 健康，后端监听 58080，前端监听 3001。
- Nimbus 可登录并打开会员管理；浏览器无控制台错误。
- 同一时间暮色 6 个服务和 Nimbus 单体均保持运行。

## 6. 验证记录

- 2026-07-18：Nimbus 后端全量构建通过，`./scripts/build-local.sh` 成功。
- 2026-07-18：Nimbus 后端 `58080`、前端 `3001`、PostgreSQL `25432`、Redis `26379` 与暮色端口并行运行。
- 2026-07-18：Nimbus `/actuator/health` 与 `/app-api/application/health`、`/app-api/im/health`、`/app-api/app/health` 均返回 `UP`。
- 2026-07-18：Nimbus `admin/admin123` 登录成功，会员管理分页接口返回正常空列表。
