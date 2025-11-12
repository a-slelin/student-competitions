package a.slelin.work.backend.data.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

public record SortDto(@NotNull @Pattern(regexp = "^[A-Za-z.]+$") String property,
                      @NotNull @Pattern(regexp = "^(?i)asc|desc$") String direction) implements ReadDto {
}
