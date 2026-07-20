# 产品迭代

1. 先稳定 System、Infra、Member、Pay 基础能力。
2. Application、IM、App 从空模板开始，按业务 Spec 逐步实现。
3. 每次只让一个 P0/P1 Spec 处于 implementing 状态。
4. 数据迁移、接口兼容、灰度和回滚必须在 Spec 中说明。
5. 当独立扩缩容、故障隔离或团队边界有真实证据时再拆微服务。

