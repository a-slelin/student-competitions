package a.slelin.work.backend.service;

import a.slelin.work.backend.data.dto.ReadDto;
import a.slelin.work.backend.data.dto.SaveDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.filter.FilterChain;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.data.domain.Page;

import java.io.Serializable;

public interface CrudService<I extends Serializable, RD extends ReadDto, SD extends SaveDto> {

    // Read

    @NotNull
    SheetDto<RD> get(@NotNull @Valid Page<RD> page);

    @NotNull
    SheetDto<RD> getByFilter(@NotNull @Valid FilterChain filter, @NotNull @Valid Page<RD> page);

    @NotNull
    RD getById(@NotNull I id);

    // Create

    @NotNull
    I save(SD instance);

    // Update

    @NotNull
    RD update(@NotNull I id, @NotNull @Valid SD instance);

    @NotNull
    RD patch(@NotNull I id, @Valid SD instance);

    // Delete

    default void delete() {
        throw new UnsupportedOperationException("Delete all method is not supported.");
    }

    void deleteById(@NotNull I id);

    default void deleteByFilter(@NotNull @Valid FilterChain filter) {
        throw new UnsupportedOperationException("Delete by filter method is not supported.");
    }
}
