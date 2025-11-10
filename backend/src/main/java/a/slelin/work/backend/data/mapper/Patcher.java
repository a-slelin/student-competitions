package a.slelin.work.backend.data.mapper;

import a.slelin.work.backend.data.dto.SaveDto;
import a.slelin.work.backend.data.entity.BaseEntity;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

public interface Patcher<E extends BaseEntity, SD extends SaveDto> {

    void patch(@NotNull @Valid SD dto, @NotNull @Valid E entity);
}
