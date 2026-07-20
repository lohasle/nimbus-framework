package com.nimbus.module.im.controller.app;

import com.nimbus.framework.common.pojo.CommonResult;
import com.nimbus.framework.tenant.core.aop.TenantIgnore;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.security.PermitAll;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static com.nimbus.framework.common.pojo.CommonResult.success;

@Tag(name = "APP - IM 模块示例")
@RestController
@RequestMapping("/im")
@TenantIgnore
public class ImHealthController {

    @GetMapping("/health")
    @PermitAll
    @Operation(summary = "IM 模块健康示例")
    public CommonResult<String> health() {
        return success("UP");
    }
}
