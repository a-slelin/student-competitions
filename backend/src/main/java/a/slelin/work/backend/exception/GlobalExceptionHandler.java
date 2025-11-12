package a.slelin.work.backend.exception;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.ConstraintViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    public static ErrorResponse.ErrorResponseBuilder buildDefault(Exception e, HttpServletRequest request) {
        return ErrorResponse.builder()
                .path(request.getRequestURI())
                .method(request.getMethod())
                .message(e.getMessage())
                .exception(e.getClass().getSimpleName())
                .causeException(e.getCause() == null ? null : e.getCause().getClass().getSimpleName())
                .timeStamp(LocalDateTime.now());
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<ErrorResponse> handleValidationException(ConstraintViolationException e,
                                                                   HttpServletRequest request) {
        List<ValidationError> errors = e.getConstraintViolations().stream()
                .map(ValidationError::fromConstraintViolation)
                .toList();

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                buildDefault(e, request)
                        .httpStatus(HttpStatus.BAD_REQUEST.value())
                        .debugMessage("Validation failed.")
                        .details(Map.of("errors", errors))
                        .build()
        );
    }

    @ExceptionHandler(FilterException.class)
    public ResponseEntity<ErrorResponse> handleFilterException(FilterException e,
                                                               HttpServletRequest request) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                buildDefault(e, request)
                        .httpStatus(HttpStatus.BAD_REQUEST.value())
                        .debugMessage("Filtering failed.")
                        .build()
        );
    }

    @ExceptionHandler(NotUniqueFieldException.class)
    public ResponseEntity<ErrorResponse> handleNotUniqueFieldException(NotUniqueFieldException e,
                                                                       HttpServletRequest request) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
                buildDefault(e, request)
                        .httpStatus(HttpStatus.BAD_REQUEST.value())
                        .debugMessage("Entity's field is not unique.")
                        .details(Map.of("class", e.getClazz().getSimpleName(),
                                "field", e.getField(),
                                "value", e.getValue()))
                        .build()
        );
    }

    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleEntityNotFoundException(EntityNotFoundException e,
                                                                       HttpServletRequest request) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(
                buildDefault(e, request)
                        .httpStatus(HttpStatus.NOT_FOUND.value())
                        .debugMessage("Entity not found.")
                        .details(Map.of("class", e.getClazz().getSimpleName(),
                                "field", e.getField(),
                                "value", e.getValue()))
                        .build()
        );
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<ErrorResponse> handleRuntimeException(RuntimeException e,
                                                                HttpServletRequest request) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                buildDefault(e, request)
                        .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR.value())
                        .debugMessage("Unexpected error.")
                        .build()
        );
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleException(Exception e, HttpServletRequest request) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                buildDefault(e, request)
                        .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR.value())
                        .debugMessage("Fatal error.")
                        .build()
        );
    }
}
