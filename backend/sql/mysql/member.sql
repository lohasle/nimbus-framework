-- Member center schema for MySQL 8.4.
-- Kept separate because the upstream all-in-one SQL contains member menus only.

CREATE TABLE IF NOT EXISTS `member_user` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `mobile` varchar(11) DEFAULT NULL,
    `email` varchar(50) DEFAULT NULL,
    `password` varchar(100) NOT NULL DEFAULT '',
    `status` tinyint NOT NULL DEFAULT 0,
    `register_ip` varchar(32) NOT NULL DEFAULT '',
    `register_terminal` tinyint DEFAULT NULL,
    `login_ip` varchar(50) DEFAULT '',
    `login_date` datetime DEFAULT NULL,
    `nickname` varchar(30) NOT NULL DEFAULT '',
    `avatar` varchar(512) NOT NULL DEFAULT '',
    `name` varchar(30) DEFAULT '',
    `sex` tinyint DEFAULT 0,
    `birthday` datetime DEFAULT NULL,
    `area_id` int DEFAULT NULL,
    `mark` varchar(255) DEFAULT NULL,
    `point` int NOT NULL DEFAULT 0,
    `tag_ids` varchar(255) DEFAULT NULL,
    `level_id` bigint DEFAULT NULL,
    `experience` int NOT NULL DEFAULT 0,
    `group_id` bigint DEFAULT NULL,
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `idx_member_user_tenant_mobile` (`tenant_id`, `mobile`),
    KEY `idx_member_user_level_id` (`level_id`),
    KEY `idx_member_user_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员用户';

CREATE TABLE IF NOT EXISTS `member_tag` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `name` varchar(30) NOT NULL DEFAULT '',
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员标签';

CREATE TABLE IF NOT EXISTS `member_group` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `name` varchar(30) NOT NULL DEFAULT '',
    `status` tinyint NOT NULL DEFAULT 0,
    `remark` varchar(255) NOT NULL DEFAULT '',
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员分组';

CREATE TABLE IF NOT EXISTS `member_level` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `name` varchar(30) NOT NULL DEFAULT '',
    `level` int NOT NULL DEFAULT 0,
    `experience` int NOT NULL DEFAULT 0,
    `discount_percent` tinyint NOT NULL DEFAULT 100,
    `icon` varchar(255) NOT NULL DEFAULT '',
    `background_url` varchar(255) NOT NULL DEFAULT '',
    `status` tinyint NOT NULL DEFAULT 0,
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员等级';

CREATE TABLE IF NOT EXISTS `member_level_record` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `level_id` bigint NOT NULL,
    `level` int NOT NULL DEFAULT 0,
    `discount_percent` tinyint NOT NULL DEFAULT 100,
    `experience` int NOT NULL DEFAULT 0,
    `user_experience` int NOT NULL DEFAULT 0,
    `remark` varchar(255) NOT NULL DEFAULT '',
    `description` varchar(255) NOT NULL DEFAULT '',
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `idx_member_level_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员等级记录';

CREATE TABLE IF NOT EXISTS `member_experience_record` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `biz_id` varchar(64) NOT NULL DEFAULT '',
    `biz_type` tinyint NOT NULL DEFAULT 0,
    `title` varchar(30) NOT NULL DEFAULT '',
    `description` varchar(512) NOT NULL DEFAULT '',
    `experience` int NOT NULL DEFAULT 0,
    `total_experience` int NOT NULL DEFAULT 0,
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `idx_member_experience_record_user_id` (`user_id`),
    KEY `idx_member_experience_record_user_biz_type` (`user_id`, `biz_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员经验记录';

CREATE TABLE IF NOT EXISTS `member_point_record` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `biz_id` varchar(255) NOT NULL,
    `biz_type` tinyint NOT NULL,
    `title` varchar(255) NOT NULL,
    `description` varchar(5000) DEFAULT NULL,
    `point` int NOT NULL,
    `total_point` int NOT NULL,
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `idx_member_point_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员积分记录';

CREATE TABLE IF NOT EXISTS `member_sign_in_config` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `day` int NOT NULL,
    `point` int NOT NULL,
    `experience` int NOT NULL DEFAULT 0,
    `status` tinyint NOT NULL DEFAULT 0,
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员签到规则';

CREATE TABLE IF NOT EXISTS `member_sign_in_record` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `day` int NOT NULL,
    `point` int NOT NULL DEFAULT 0,
    `experience` int NOT NULL DEFAULT 0,
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `idx_member_sign_in_record_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员签到记录';

CREATE TABLE IF NOT EXISTS `member_config` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `point_trade_deduct_enable` bit(1) NOT NULL DEFAULT b'0',
    `point_trade_deduct_unit_price` int NOT NULL DEFAULT 0,
    `point_trade_deduct_max_price` int NOT NULL DEFAULT 0,
    `point_trade_give_point` int NOT NULL DEFAULT 0,
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员配置';

CREATE TABLE IF NOT EXISTS `member_address` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint NOT NULL,
    `name` varchar(255) NOT NULL DEFAULT '',
    `mobile` varchar(20) NOT NULL DEFAULT '',
    `area_id` bigint NOT NULL,
    `detail_address` varchar(255) NOT NULL DEFAULT '',
    `default_status` bit(1) NOT NULL DEFAULT b'0',
    `creator` varchar(64) DEFAULT '',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updater` varchar(64) DEFAULT '',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `deleted` bit(1) NOT NULL DEFAULT b'0',
    `tenant_id` bigint NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `idx_member_address_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员收件地址';
