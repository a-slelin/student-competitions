package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record SaveResultDto(String code,
                            String name,
                            Integer order) implements SaveDto {
}
