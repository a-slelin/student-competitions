package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record SaveParticipationDto(String student,
                                   String competition,
                                   String level,
                                   String result,
                                   Integer year,
                                   String supervisor,
                                   Integer points,
                                   String description) implements SaveDto {
}
