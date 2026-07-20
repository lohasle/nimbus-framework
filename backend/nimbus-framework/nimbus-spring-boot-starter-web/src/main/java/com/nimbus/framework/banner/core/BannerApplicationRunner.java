package com.nimbus.framework.banner.core;

import cn.hutool.core.thread.ThreadUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.beans.factory.annotation.Value;

import java.util.concurrent.TimeUnit;

/**
 * 项目启动成功后，提供文档相关的地址
 *
 * @author Nimbus Platform Team
 */
@Slf4j
public class BannerApplicationRunner implements ApplicationRunner {

    @Value("${server.port:48080}")
    private int serverPort;

    @Override
    public void run(ApplicationArguments args) {
        ThreadUtil.execute(() -> {
            ThreadUtil.sleep(1, TimeUnit.SECONDS); // 延迟 1 秒，保证输出到结尾
            log.info("\n----------------------------------------------------------\n\t" +
                            "项目启动成功！\n\t" +
                            "接口文档: \t{} \n\t" +
                            "健康检查: \t{} \n" +
                            "----------------------------------------------------------",
                    "http://localhost:" + serverPort + "/swagger-ui",
                    "http://localhost:" + serverPort + "/actuator/health");
        });
    }

}
