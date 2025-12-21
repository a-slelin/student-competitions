package a.slelin.work.backend.exception;

public class BusinessFault extends RuntimeException {

    public BusinessFault() {
        super("A business error has occurred");
    }

    public BusinessFault(String message) {
        super(message);
    }
}
