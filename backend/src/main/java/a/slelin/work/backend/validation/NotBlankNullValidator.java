package a.slelin.work.backend.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class NotBlankNullValidator implements ConstraintValidator<NotBlankNull, String> {

    @Override
    public boolean isValid(String s, ConstraintValidatorContext cvc) {
        return s == null || !s.isBlank();
    }
}
