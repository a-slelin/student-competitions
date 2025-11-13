package a.slelin.work.backend.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PhoneValidator implements ConstraintValidator<Phone, String> {

    private PhoneLocal phoneLocal;

    @Override
    public void initialize(Phone phone) {
        this.phoneLocal = phone.phoneLocal();
    }

    @Override
    public boolean isValid(String phone, ConstraintValidatorContext cvc) {
        return phone == null || phoneLocal.isValid(phone);
    }
}
