package a.slelin.work.backend;

import a.slelin.work.backend.controller.ControllerConfig;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(ControllerConfig.class)
public class AppConfig {
}
