package a.slelin.work.backend.data.mapper;

import a.slelin.work.backend.data.dto.ReadLevelDto;
import a.slelin.work.backend.data.dto.SaveLevelDto;
import a.slelin.work.backend.data.entity.Level;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;

@Component
@Validated
public class LevelMapper implements Mapper<Level, ReadLevelDto, SaveLevelDto> {

    @Override
    @NotNull
    public ReadLevelDto toDTO(@NotNull @Valid Level entity) {
        return ReadLevelDto.builder()
                .code(entity.getCode())
                .name(entity.getName())
                .order(entity.getSortOrder())
                .build();
    }

    @Override
    @NotNull
    public Level toEntity(@NotNull @Valid SaveLevelDto dto) {
        return new Level(dto.name(), dto.order());
    }

    @Override
    public void patch(@NotNull @Valid SaveLevelDto dto, @NotNull @Valid Level entity) {
        if (dto.name() != null) {
            entity.setName(dto.name());
        }

        if (dto.order() != null) {
            entity.setSortOrder(dto.order());
        }
    }
}
