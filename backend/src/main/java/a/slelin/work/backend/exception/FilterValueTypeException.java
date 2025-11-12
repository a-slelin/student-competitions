package a.slelin.work.backend.exception;

import lombok.Getter;

@Getter
public class FilterValueTypeException extends FilterValueException {

    private final Class<?> expectedType;

    public FilterValueTypeException(Object value, Class<?> expectedType) {
        super(value, "Value \"%s\" cannot convert to \"%s\"."
                .formatted(value.toString(), expectedType.getSimpleName()));
        this.expectedType = expectedType;
    }
}
