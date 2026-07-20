# SPEC-003 会员中心数据库与动态路由修复 v1

> Status: verified  
> Number: SPEC-003  
> Priority: P0  
> Version: 2026-07-17

## 1. 背景与问题

会员中心前后端模块已装配，但 PostgreSQL 和 MySQL 基础初始化脚本只包含会员菜单，缺少会员域业务表。进入会员管理时，会员、等级、标签和分组接口同时因表不存在而返回系统异常。动态菜单页面直接刷新还会错误保留首次匹配的 404 路由名称。

## 2. 目标

- 补齐 Member 模块 11 张业务表、序列和必要索引。
- PostgreSQL 为主验收数据库，同时提供 MySQL 8.4 等价初始化脚本。
- 修复动态菜单页面首次直达或刷新后落入 404。
- 与 Muse 保持脚手架基础能力一致。
- 核对 Application 与 App 模块是否已具备 APP/小程序版本发布能力。

## 3. 非目标

- 不在本 Spec 实现 APP 安装包、灰度、渠道或小程序版本发布业务。
- 不修改会员页面样式和现有 REST API 契约。
- 不生成演示会员数据。

## 4. 数据结构

- 核心：`member_user`、`member_tag`、`member_group`、`member_level`、`member_config`。
- 记录：`member_level_record`、`member_experience_record`、`member_point_record`、`member_sign_in_config`、`member_sign_in_record`。
- 地址：`member_address`。
- 所有表支持租户隔离、逻辑删除和审计字段；PostgreSQL 主键序列名与 `@KeySequence` 保持一致。

## 5. 错误与兼容

- SQL 必须可重复执行，不删除已有会员数据。
- PostgreSQL 迁移失败必须整体回滚。
- MySQL 使用 `AUTO_INCREMENT`，PostgreSQL 使用显式序列。
- 动态路由重新导航只使用原始 URL，不携带初次 404 匹配结果。

## 6. 验收与测试

- PostgreSQL 和 MySQL 初始化脚本均通过空库执行验证。
- Nimbus 前端类型检查和构建通过。
- 明确记录应用发布中心的现状与缺口，不把 OAuth2 客户端管理误认为发布中心。

## 7. 验证记录

- PostgreSQL 与 MySQL 会员初始化脚本均通过空库执行和重复执行验证，11 张会员表完整创建。
- 当前 Muse PostgreSQL、MySQL 数据库已补齐会员表；后端健康状态为 `UP`。
- 真实浏览器验证会员管理、标签、等级、分组、积分页面均无控制台错误，`/member/user` 与 `/member/record` 直接刷新正常。
- Muse、Nimbus 前端均通过类型检查和本地构建；两套 Compose 配置均通过解析校验。
- JDK 25 下执行 `mvn -pl muse-module-member -am test` 成功，Member 模块 31 个测试 0 失败、0 错误、1 跳过。
- 应用发布中心审计结论：`muse-module-application` 与 `muse-module-app` 目前仅为边界模板，不包含 APP/小程序版本、渠道、制品、灰度或发布流程实现。
