package a.slelin.work.backend.data.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record ReadCompetitionDto(@NotBlank String id,
                                 String name,
                                 String organizer,
                                 String type) implements ReadDto {
}
