package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record SaveLevelDto(String code,
                           String name,
                           Integer order) implements SaveDto {
}
