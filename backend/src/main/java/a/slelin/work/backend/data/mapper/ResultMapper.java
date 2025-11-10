package a.slelin.work.backend.data.mapper;

import a.slelin.work.backend.data.dto.ReadResultDto;
import a.slelin.work.backend.data.dto.SaveResultDto;
import a.slelin.work.backend.data.entity.Result;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;

@Component
@Validated
public class ResultMapper implements Mapper<Result, ReadResultDto, SaveResultDto> {

    @Override
    @NotNull
    public ReadResultDto toDTO(@NotNull @Valid Result entity) {
        return ReadResultDto.builder()
                .code(entity.getCode())
                .name(entity.getName())
                .order(entity.getSortOrder())
                .build();
    }

    @Override
    @NotNull
    public Result toEntity(@NotNull @Valid SaveResultDto dto) {
        return new Result(dto.name(), dto.order());
    }

    @Override
    public void patch(@NotNull @Valid SaveResultDto dto, @NotNull @Valid Result entity) {
        if (dto.name() != null) {
            entity.setName(dto.name());
        }

        if (dto.order() != null) {
            entity.setSortOrder(dto.order());
        }
    }
}
