package a.slelin.work.backend.exception;

import lombok.Getter;

@Getter
public class FilterValueException extends FilterException {

    private final Object value;

    public FilterValueException(Object value) {
        super("Invalid filter value : " + value);
        this.value = value;
    }

    public FilterValueException(Object value, String message) {
        super(message);
        this.value = value;
    }
}
