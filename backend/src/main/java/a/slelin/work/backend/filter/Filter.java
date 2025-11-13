package a.slelin.work.backend.filter;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

public record Filter(@NotNull @Pattern(regexp = "^[A-Za-z.]+$") String field,
                     @NotNull Operation operation,
                     Object value,
                     Object value2) {

    public static Filter of(String field, Operation operation, Object value) {
        return new Filter(field, operation, value, null);
    }
}
