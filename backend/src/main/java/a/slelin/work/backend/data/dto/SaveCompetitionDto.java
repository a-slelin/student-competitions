package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record SaveCompetitionDto(String name,
                                 String organizer,
                                 String type) implements SaveDto {
}
