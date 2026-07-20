package com.nimbus.module.application.controller.app;

import com.nimbus.framework.common.pojo.CommonResult;
import com.nimbus.framework.tenant.core.aop.TenantIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.PermitAll;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static com.nimbus.framework.common.pojo.CommonResult.success;

@Tag(name = "APP - Application 模块示例")
@RestController
@RequestMapping("/application")
@TenantIgnore
public class ApplicationHealthController {

    @GetMapping("/health")
    @PermitAll
    @Operation(summary = "Application 模块健康示例")
    public CommonResult<String> health() {
        return success("UP");
    }
}
