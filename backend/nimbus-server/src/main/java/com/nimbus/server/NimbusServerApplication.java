package com.nimbus.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 项目的启动类
 *
 * @author Nimbus Platform Team
 */
@SuppressWarnings("SpringComponentScan") // 忽略 IDEA 无法识别 ${nimbus.info.base-package}
@SpringBootApplication(scanBasePackages = {"${nimbus.info.base-package}.server", "${nimbus.info.base-package}.module"})
public class NimbusServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(NimbusServerApplication.class, args);
    }

}
