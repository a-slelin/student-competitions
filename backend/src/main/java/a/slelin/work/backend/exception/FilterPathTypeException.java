package a.slelin.work.backend.exception;

import lombok.Getter;

@Getter
public class FilterPathTypeException extends FilterPathException {

    private final Class<?> realType;

    private final Class<?> expectedType;

    public FilterPathTypeException(String path, Class<?> realType, Class<?> expectedType) {
        this(path, realType, expectedType,
                "Path \"%s\" cannot convert to \"%s\" because its type is \"%s\""
                .formatted(path, expectedType.getSimpleName(), realType.getSimpleName()));
    }

    public FilterPathTypeException(String path, Class<?> realType, Class<?> expectedType, String message) {
        super(path, message);
        this.realType = realType;
        this.expectedType = expectedType;
    }
}
