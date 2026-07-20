package com.nimbus.framework.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 文档地址
 *
 * @author Nimbus Framework
 */
@Getter
@AllArgsConstructor
public enum DocumentEnum {

    REDIS_INSTALL("https://gitee.com/zhijiantianya/nimbus-platform/issues/I4VCSJ", "Redis 安装文档"),
    TENANT("https://doc.nimbus.local", "SaaS 多租户文档");

    private final String url;
    private final String memo;

}
