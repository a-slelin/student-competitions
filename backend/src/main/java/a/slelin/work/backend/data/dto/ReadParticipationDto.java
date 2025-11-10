package a.slelin.work.backend.data.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

import java.net.URI;

@Builder
public record ReadParticipationDto(@NotNull URI student,
                                   @NotNull URI competition,
                                   @NotNull URI level,
                                   @NotNull URI result,
                                   Integer year,
                                   String supervisor,
                                   Integer points,
                                   String description,
                                   Boolean isBlocked) implements ReadDto {
}
