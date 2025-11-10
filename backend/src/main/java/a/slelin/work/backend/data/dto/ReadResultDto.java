package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record ReadResultDto(String code,
                            String name,
                            Integer order) implements ReadDto {
}
