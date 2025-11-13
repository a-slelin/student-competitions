package a.slelin.work.backend.exception;

import lombok.Getter;

@Getter
public class FilterParseOperationException extends FilterException {

    private final String invalidOperation;

    public FilterParseOperationException(String invalidOperation) {
        super("Cannot parse filter operation : " + invalidOperation);
        this.invalidOperation = invalidOperation;
    }

    public FilterParseOperationException(String invalidOperation, String message) {
        super(message);
        this.invalidOperation = invalidOperation;
    }
}
