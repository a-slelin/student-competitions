package a.slelin.work.backend.exception;

import lombok.Getter;

@Getter
public class FilterPathException extends FilterException {

    private final String path;

    public FilterPathException(String path) {
        super("Invalid filter path : " + path);
        this.path = path;
    }

    public FilterPathException(String path, String message) {
        super(message);
        this.path = path;
    }
}
