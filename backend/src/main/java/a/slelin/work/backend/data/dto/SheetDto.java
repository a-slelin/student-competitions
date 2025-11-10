package a.slelin.work.backend.data.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

import java.util.List;

@Builder
public record SheetDto<T>(@NotNull @Valid List<T> content,
                          @NotNull @Valid PageDto page) implements ReadDto {
}
