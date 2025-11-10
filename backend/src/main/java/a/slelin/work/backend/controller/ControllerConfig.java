package a.slelin.work.backend.controller;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.bind.DefaultValue;

@ConfigurationProperties(prefix = "api")
public record ControllerConfig(@DefaultValue("http") String protocol,
                               @DefaultValue("localhost") String server,
                               @DefaultValue("8080") Integer port,
                               @DefaultValue("api") String apiPrefix,
                               @DefaultValue("levels") String levelPrefix,
                               @DefaultValue("results") String resultPrefix,
                               @DefaultValue("students") String studentPrefix,
                               @DefaultValue("competitions") String competitionPrefix,
                               @DefaultValue("participations") String participationPrefix) {

    public String getBaseUri() {
        return "%s://%s:%d".formatted(protocol, server, port);
    }

    public String getLevelUri() {
        return "%s/%s/%s".formatted(getBaseUri(), apiPrefix, levelPrefix);
    }

    public String getResultUri() {
        return "%s/%s/%s".formatted(getBaseUri(), apiPrefix, resultPrefix);
    }

    public String getStudentUri() {
        return "%s/%s/%s".formatted(getBaseUri(), apiPrefix, studentPrefix);
    }

    public String getCompetitionUri() {
        return "%s/%s/%s".formatted(getBaseUri(), apiPrefix, competitionPrefix);
    }

    public String getParticipationUri() {
        return "%s/%s/%s".formatted(getBaseUri(), apiPrefix, participationPrefix);
    }
}
