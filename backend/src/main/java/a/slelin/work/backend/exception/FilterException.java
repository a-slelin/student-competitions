package a.slelin.work.backend.exception;

public class FilterException extends RuntimeException {

    public FilterException() {
        super("Filtering process exception.");
    }

    public FilterException(String message) {
        super(message);
    }
}
