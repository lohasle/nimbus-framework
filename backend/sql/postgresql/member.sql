-- Member center schema for PostgreSQL.
-- The upstream all-in-one SQL contains member menus, but omits the member tables.

BEGIN;

CREATE SEQUENCE IF NOT EXISTS member_user_seq START 1;
CREATE TABLE IF NOT EXISTS member_user (
    id bigint PRIMARY KEY,
    mobile varchar(11),
    email varchar(50),
    password varchar(100) NOT NULL DEFAULT '',
    status smallint NOT NULL DEFAULT 0,
    register_ip varchar(32) NOT NULL DEFAULT '',
    register_terminal smallint,
    login_ip varchar(50) DEFAULT '',
    login_date timestamp,
    nickname varchar(30) NOT NULL DEFAULT '',
    avatar varchar(512) NOT NULL DEFAULT '',
    name varchar(30) DEFAULT '',
    sex smallint DEFAULT 0,
    birthday timestamp,
    area_id integer,
    mark varchar(255),
    point integer NOT NULL DEFAULT 0,
    tag_ids varchar(255),
    level_id bigint,
    experience integer NOT NULL DEFAULT 0,
    group_id bigint,
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX IF NOT EXISTS uk_member_user_tenant_mobile
    ON member_user (tenant_id, mobile) WHERE deleted = 0 AND mobile IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_member_user_level_id ON member_user (level_id);
CREATE INDEX IF NOT EXISTS idx_member_user_group_id ON member_user (group_id);

CREATE SEQUENCE IF NOT EXISTS member_tag_seq START 1;
CREATE TABLE IF NOT EXISTS member_tag (
    id bigint PRIMARY KEY,
    name varchar(30) NOT NULL DEFAULT '',
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);

CREATE SEQUENCE IF NOT EXISTS member_group_seq START 1;
CREATE TABLE IF NOT EXISTS member_group (
    id bigint PRIMARY KEY,
    name varchar(30) NOT NULL DEFAULT '',
    status smallint NOT NULL DEFAULT 0,
    remark varchar(255) NOT NULL DEFAULT '',
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);

CREATE SEQUENCE IF NOT EXISTS member_level_seq START 1;
CREATE TABLE IF NOT EXISTS member_level (
    id bigint PRIMARY KEY,
    name varchar(30) NOT NULL DEFAULT '',
    level integer NOT NULL DEFAULT 0,
    experience integer NOT NULL DEFAULT 0,
    discount_percent smallint NOT NULL DEFAULT 100,
    icon varchar(255) NOT NULL DEFAULT '',
    background_url varchar(255) NOT NULL DEFAULT '',
    status smallint NOT NULL DEFAULT 0,
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);

CREATE SEQUENCE IF NOT EXISTS member_level_record_seq START 1;
CREATE TABLE IF NOT EXISTS member_level_record (
    id bigint PRIMARY KEY,
    user_id bigint NOT NULL,
    level_id bigint NOT NULL,
    level integer NOT NULL DEFAULT 0,
    discount_percent smallint NOT NULL DEFAULT 100,
    experience integer NOT NULL DEFAULT 0,
    user_experience integer NOT NULL DEFAULT 0,
    remark varchar(255) NOT NULL DEFAULT '',
    description varchar(255) NOT NULL DEFAULT '',
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_member_level_record_user_id ON member_level_record (user_id);

CREATE SEQUENCE IF NOT EXISTS member_experience_record_seq START 1;
CREATE TABLE IF NOT EXISTS member_experience_record (
    id bigint PRIMARY KEY,
    user_id bigint NOT NULL,
    biz_id varchar(64) NOT NULL DEFAULT '',
    biz_type smallint NOT NULL DEFAULT 0,
    title varchar(30) NOT NULL DEFAULT '',
    description varchar(512) NOT NULL DEFAULT '',
    experience integer NOT NULL DEFAULT 0,
    total_experience integer NOT NULL DEFAULT 0,
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_member_experience_record_user_id
    ON member_experience_record (user_id);
CREATE INDEX IF NOT EXISTS idx_member_experience_record_user_biz_type
    ON member_experience_record (user_id, biz_type);

CREATE SEQUENCE IF NOT EXISTS member_point_record_seq START 1;
CREATE TABLE IF NOT EXISTS member_point_record (
    id bigint PRIMARY KEY,
    user_id bigint NOT NULL,
    biz_id varchar(255) NOT NULL,
    biz_type smallint NOT NULL,
    title varchar(255) NOT NULL,
    description varchar(5000),
    point integer NOT NULL,
    total_point integer NOT NULL,
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_member_point_record_user_id ON member_point_record (user_id);

CREATE SEQUENCE IF NOT EXISTS member_sign_in_config_seq START 1;
CREATE TABLE IF NOT EXISTS member_sign_in_config (
    id bigint PRIMARY KEY,
    day integer NOT NULL,
    point integer NOT NULL,
    experience integer NOT NULL DEFAULT 0,
    status smallint NOT NULL DEFAULT 0,
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);

CREATE SEQUENCE IF NOT EXISTS member_sign_in_record_seq START 1;
CREATE TABLE IF NOT EXISTS member_sign_in_record (
    id bigint PRIMARY KEY,
    user_id bigint NOT NULL,
    day integer NOT NULL,
    point integer NOT NULL DEFAULT 0,
    experience integer NOT NULL DEFAULT 0,
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_member_sign_in_record_user_id ON member_sign_in_record (user_id);

CREATE SEQUENCE IF NOT EXISTS member_config_seq START 1;
CREATE TABLE IF NOT EXISTS member_config (
    id bigint PRIMARY KEY,
    point_trade_deduct_enable boolean NOT NULL DEFAULT false,
    point_trade_deduct_unit_price integer NOT NULL DEFAULT 0,
    point_trade_deduct_max_price integer NOT NULL DEFAULT 0,
    point_trade_give_point integer NOT NULL DEFAULT 0,
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);

CREATE SEQUENCE IF NOT EXISTS member_address_seq START 1;
CREATE TABLE IF NOT EXISTS member_address (
    id bigint PRIMARY KEY,
    user_id bigint NOT NULL,
    name varchar(255) NOT NULL DEFAULT '',
    mobile varchar(20) NOT NULL DEFAULT '',
    area_id bigint NOT NULL,
    detail_address varchar(255) NOT NULL DEFAULT '',
    default_status boolean NOT NULL DEFAULT false,
    creator varchar(64) DEFAULT '',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updater varchar(64) DEFAULT '',
    update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted smallint NOT NULL DEFAULT 0,
    tenant_id bigint NOT NULL DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_member_address_user_id ON member_address (user_id);

COMMIT;
