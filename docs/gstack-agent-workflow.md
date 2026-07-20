# 交付工作流

```text
Think -> Spec -> Plan -> Build -> Review -> Test/QA -> Ship -> Reflect
```

| 阶段 | 输出 |
| --- | --- |
| Think | 现状证据、问题边界、关键假设 |
| Spec | 目标、非目标、接口、数据、验收标准 |
| Plan | 可执行步骤和验证点 |
| Build | 只实现当前 Spec 范围 |
| Review | 架构、数据、安全、兼容性检查 |
| Test/QA | 单测、集成测试、构建、运行态或浏览器验证 |
| Ship | 变更说明、迁移与回滚信息 |
| Reflect | 把稳定经验沉淀为 Rule 或 Skill |

简单局部修改可跳过独立 Spec，但仍需明确验收与验证。

