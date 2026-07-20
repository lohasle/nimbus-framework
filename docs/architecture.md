# Nimbus Framework脚手架架构

## 依赖方向

```text
nimbus-server
  -> nimbus-module-app             集成编排
      -> application / im / member / pay / system / infra APIs
  -> nimbus-module-application     应用中心模板
  -> nimbus-module-im              IM 模板
  -> nimbus-module-member          用户中心
  -> nimbus-module-pay             支付中心
  -> nimbus-module-system          权限与平台配置
  -> nimbus-module-infra           基础设施
  -> nimbus-framework              通用技术能力
```

禁止 System、Infra、Member、Pay、Application、IM 反向依赖 App 集成模块。

## 运行形态

首期采用单 JVM 模块化单体，MySQL 8.4 与 Redis 独立部署。模块 API 边界为未来拆分服务预留，但本期不引入 Nacos、Gateway、Seata 等微服务复杂度。
