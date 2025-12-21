package a.slelin.work.backend.exception;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Builder
public record ErrorResponse(@NotBlank String path,
                            @NotBlank String method,
                            @NotNull @Min(100) @Max(599) Integer httpStatus,
                            @NotBlank String debugMessage,
                            @NotBlank String message,
                            @NotBlank String exception,
                            String causeException,
                            Map<String, Object> details,
                            @NotNull LocalDateTime timeStamp) {

    public final static DateTimeFormatter TIME_STAMP_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss");

    @Override
    public String toString() {
        return """
                
                ErrorResponse:
                    path = %s,
                    method = %s,
                    httpStatus = %s,
                    debugMessage = %s,
                    message = %s,
                    exception = %s,
                    causeException = %s,
                    details = %s,
                    timestamp = %s.
                
                """.formatted(path, method, httpStatus, debugMessage, message, exception, causeException,
                details, timeStamp == null ? "none" : timeStamp.format(TIME_STAMP_FORMATTER));
    }
}