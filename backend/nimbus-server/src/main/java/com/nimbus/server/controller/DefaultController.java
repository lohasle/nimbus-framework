package com.nimbus.server.controller;

import com.nimbus.framework.common.pojo.CommonResult;
import jakarta.annotation.security.PermitAll;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/** Nimbus Framework基础状态入口。 */
@RestController
public class DefaultController {

    @GetMapping("/")
    @PermitAll
    public CommonResult<Map<String, String>> index() {
        return CommonResult.success(Map.of(
                "application", "nimbus-platform",
                "status", "ready"));
    }
}
