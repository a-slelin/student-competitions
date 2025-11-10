package a.slelin.work.backend.validation;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.regex.Pattern;

@Getter
@AllArgsConstructor
public enum PhoneLocal {
    RU(Pattern.compile("^7\\d{10}$"));

    private final Pattern pattern;

    public boolean isValid(String phone) {
        return pattern.matcher(phone).matches();
    }
}
