# Nimbus Platform Agent Instructions

本仓库使用 Rule / Spec / Skill 驱动的 DDD、SDD、TDD 工作流。

## Source of Truth

非简单修改按顺序阅读：

1. `docs/README.md`
2. `docs/agent-context.md`
3. `docs/gstack-agent-workflow.md`
4. `docs/development-standards.md`
5. `docs/specs/README.md`
6. 当前生效的 `docs/specs/SPEC-*.md`

## Workflow

```text
Think -> Spec -> Plan -> Build -> Review -> Test/QA -> Ship -> Reflect
```

## Rules

- 跨模块或影响接口、数据结构的变更必须先创建或更新编号 Spec。
- Java 根包固定为 `com.nimbus`，禁止新增旧脚手架包名。
- 新模块必须遵守 API、业务、数据访问边界，不允许反向依赖集成应用模块。
- 所有 REST API 必须有 OpenAPI 注解和明确的输入、输出、错误契约。
- MySQL 8.4 是默认与主验收数据库，同时保留 PostgreSQL 适配；表结构变更必须同步两套 SQL。
- 不覆盖无关工作区修改；完成前必须运行对应测试和构建。
- 无法执行验证时必须说明原因和剩余风险，禁止将未验证描述为完成。
