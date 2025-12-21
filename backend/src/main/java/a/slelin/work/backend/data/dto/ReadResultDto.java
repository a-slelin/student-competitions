package a.slelin.work.backend.data.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record ReadResultDto(@NotBlank String code,
                            String name,
                            Integer order) implements ReadDto {
}
