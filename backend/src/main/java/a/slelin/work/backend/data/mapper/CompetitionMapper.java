package a.slelin.work.backend.data.mapper;

import a.slelin.work.backend.data.dto.ReadCompetitionDto;
import a.slelin.work.backend.data.dto.SaveCompetitionDto;
import a.slelin.work.backend.data.entity.Competition;
import a.slelin.work.backend.data.entity.CompetitionType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;

@Component
@Validated
public class CompetitionMapper implements Mapper<Competition, ReadCompetitionDto, SaveCompetitionDto> {

    @Override
    @NotNull
    public ReadCompetitionDto toDTO(@NotNull @Valid Competition entity) {
        return ReadCompetitionDto.builder()
                .id(entity.getId().toString())
                .name(entity.getName())
                .organizer(entity.getOrganizer())
                .type(entity.getType().toRussian())
                .build();
    }

    @Override
    @NotNull
    public Competition toEntity(@NotNull @Valid SaveCompetitionDto dto) {
        return Competition.builder()
                .name(dto.name())
                .organizer(dto.organizer())
                .type(CompetitionType.fromRussian(dto.type()))
                .build();
    }

    @Override
    public void patch(@NotNull @Valid SaveCompetitionDto dto, @NotNull @Valid Competition entity) {
        if (dto.name() != null) {
            entity.setName(dto.name());
        }

        if (dto.organizer() != null) {
            entity.setOrganizer(dto.organizer());
        }

        if (dto.type() != null) {
            entity.setType(CompetitionType.fromRussian(dto.type()));
        }
    }
}
