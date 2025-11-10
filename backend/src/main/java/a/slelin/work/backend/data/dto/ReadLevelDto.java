package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record ReadLevelDto(String code,
                           String name,
                           Integer order) implements ReadDto {
}
