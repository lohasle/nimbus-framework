# 部署与可观测性

## 当前部署单元

当前不是多个独立微服务进程，而是一个 `nimbus-server` JVM，加 MySQL 8.4、Redis 两个基础设施进程。System、Infra、Member、Pay 是同 JVM 的领域模块；Application、IM、App 是未实现的模板边界。

最小可运行部署：

- `nimbus-server`：1 个实例，建议 2 CPU / 2–4 GB 内存。
- MySQL 8.4：建议 2 CPU / 4 GB 内存与持久化 SSD。
- Redis 7.4：建议 1 CPU / 1 GB 内存与持久化磁盘。
- 前端：静态资源可由 Nginx/CDN 托管，通常 0.25 CPU / 256 MB 即可。

上述是开发、小流量环境起点，不是十万 DAU 的容量承诺。生产资源需根据接口延迟、连接池、缓存命中率、支付峰值和压测结果确定。

## 可观测性

- 健康探针：`/actuator/health`，包含 liveness/readiness 分组。
- 指标：`/actuator/prometheus`，由 Prometheus 抓取并在 Grafana 展示。
- 链路：Micrometer Tracing + OpenTelemetry；日志格式包含 `traceId`、`spanId`。生产环境需要配置 OTLP Collector 地址。
- 应用日志：默认写入 `./logs/nimbus-server.log`；生产建议采集到 Loki、ELK 或云日志服务。
- 审计日志：系统登录、操作和 API 访问日志由 System/Infra 模块承载。

除健康探针外，不应将 Actuator 管理端点直接暴露到公网；应通过内网、认证和访问控制保护。

## 扩容路径

1. 先保持模块化单体，应用无状态化并水平扩展 `nimbus-server`。
2. MySQL 启用连接池监控、慢 SQL、只读副本和备份恢复演练。
3. Redis 做哨兵或集群化，支付回调与消息处理确保幂等。
4. 只有当模块出现独立扩缩容、团队自治或故障隔离需求时，才拆分 JVM 服务并引入注册中心、网关和消息中间件。

百万注册、十万 DAU 场景的常见瓶颈通常先出现在热点 SQL、连接池、登录/权限缓存、支付回调幂等、定时任务争抢、文件存储和外部渠道限流。必须使用真实业务模型压测，不能仅凭用户数估算服务器规格。
