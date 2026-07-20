-- Nimbus Framework初始化收敛：仅保留 System、Infra、Member、Pay 四个可用中心。
BEGIN;

CREATE TEMP TABLE nimbus_removed_menu_ids AS
WITH RECURSIVE removed AS (
    SELECT id
    FROM system_menu
    WHERE parent_id = 0
      AND path NOT IN ('/system', '/infra', '/member', '/pay')
    UNION ALL
    SELECT child.id
    FROM system_menu child
    JOIN removed parent ON child.parent_id = parent.id
)
SELECT id FROM removed;

DELETE FROM system_role_menu
WHERE menu_id IN (SELECT id FROM nimbus_removed_menu_ids);

DELETE FROM system_menu
WHERE id IN (SELECT id FROM nimbus_removed_menu_ids);

-- 移除演示账号、演示通知和外部存储密钥，仅保留可登录管理员与本地存储模板。
UPDATE system_dept SET leader_user_id = NULL WHERE leader_user_id <> 1;
DELETE FROM system_user_role WHERE user_id <> 1;
DELETE FROM system_users WHERE id <> 1;
UPDATE system_users
SET nickname = '平台管理员', email = 'platform@nimbus.com', mobile = '', avatar = NULL,
    remark = 'Nimbus Framework初始化管理员'
WHERE id = 1;

DELETE FROM system_tenant WHERE id <> 1;
UPDATE system_tenant
SET name = 'Nimbus Framework', contact_name = '平台管理员', contact_mobile = '',
    websites = 'localhost:3000,127.0.0.1:3000'
WHERE id = 1;

UPDATE system_dept SET name = 'Nimbus Framework' WHERE id = 100;
DELETE FROM system_notice;

DELETE FROM infra_file_config WHERE id <> 29;
UPDATE infra_file_config
SET name = '本地文件存储', remark = '开发环境默认存储，请在生产环境替换', master = TRUE
WHERE id = 29;

DELETE FROM system_oauth2_client WHERE id <> 1;
UPDATE system_oauth2_client
SET name = 'Nimbus Framework', logo = '', description = 'Nimbus Framework默认客户端',
    redirect_uris = '["http://localhost:3000"]'
WHERE id = 1;

COMMIT;
