package a.slelin.work.backend.validation;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.regex.Pattern;

@Getter
@AllArgsConstructor
public enum PhoneLocal {
    RU(Pattern.compile("^\\+?[78][\\s\\-]?\\(?[0-9]{3}\\)?[\\s\\-]?[0-9]{3}[\\s\\-]?[0-9]{2}[\\s\\-]?[0-9]{2}$"));

    private final Pattern pattern;

    public boolean isValid(String phone) {
        return pattern.matcher(phone).matches();
    }
}
