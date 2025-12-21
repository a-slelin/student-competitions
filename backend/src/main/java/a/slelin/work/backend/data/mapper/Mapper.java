package a.slelin.work.backend.data.mapper;

import a.slelin.work.backend.data.dto.ReadDto;
import a.slelin.work.backend.data.dto.SaveDto;
import a.slelin.work.backend.data.entity.BaseEntity;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

public interface Mapper<E extends BaseEntity, RD extends ReadDto, SD extends SaveDto> extends Patcher<E, SD> {

    @NotNull
    RD toDTO(@NotNull @Valid E entity);

    @NotNull
    E toEntity(@NotNull @Valid SD dto);
}
