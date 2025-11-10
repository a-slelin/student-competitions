package a.slelin.work.backend.data.dto;

import lombok.Builder;

@Builder
public record ReadCompetitionDto(String id,
                                 String name,
                                 String organizer,
                                 String type) implements ReadDto {
}
