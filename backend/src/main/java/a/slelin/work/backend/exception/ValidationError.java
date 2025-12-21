package a.slelin.work.backend.exception;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Path;
import lombok.Builder;

import java.util.Map;

@Builder
public record ValidationError(String field,
                              String message,
                              Object invalidValue,
                              String constraintType,
                              String propertyPath,
                              Map<String, Object> constraintDetails) {

    public static ValidationError fromConstraintViolation(ConstraintViolation<?> violation) {
        var descriptor = violation.getConstraintDescriptor();

        return ValidationError.builder()
                .field(getFieldName(violation.getPropertyPath()))
                .message(violation.getMessage())
                .invalidValue(violation.getInvalidValue())
                .constraintType(descriptor.getAnnotation().annotationType().getSimpleName())
                .propertyPath(violation.getPropertyPath().toString())
                .constraintDetails(descriptor.getAttributes())
                .build();
    }

    private static String getFieldName(Path path) {
        String fullPath = path.toString();
        return fullPath.contains(".") ?
                fullPath.substring(fullPath.lastIndexOf('.') + 1) : fullPath;
    }

    @Override
    public String toString() {
        return """
                
                ValidationError:
                    field = %s,
                    message = %s,
                    invalidValue = %s,
                    constraintType = %s,
                    propertyPath = %s,
                    constraintDetails = %s.
                
                """.formatted(field, message, invalidValue,
                constraintType, propertyPath, constraintDetails);
    }
}
