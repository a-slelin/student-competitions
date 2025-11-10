package a.slelin.work.backend.data.dto;

import jakarta.validation.constraints.NotNull;

public record SortDto(@NotNull String property,
                      @NotNull String direction) implements ReadDto {
}
