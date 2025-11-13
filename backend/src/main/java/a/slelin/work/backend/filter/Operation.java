package a.slelin.work.backend.filter;

import a.slelin.work.backend.exception.FilterParseOperationException;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@JsonDeserialize(using = OperationDeserializer.class)
public enum Operation {
    EQ("равно", "equals"),
    NEQ("не равно", "not equals"),

    GT("больше", "greater"),
    GE("больше или равно", "greater or equals"),
    LT("меньше", "less"),
    LE("меньше или равно", "less or equals"),

    LIKE("содержит", "like"),
    NOT_LIKE("не содержит", "not like"),
    STARTS_WITH("начинается с", "starts with"),
    NOT_STARTS_WITH("не начинается с", "not starts with"),
    ENDS_WITH("заканчивается", "ends with"),
    NOT_ENDS_WITH("не заканчивается", "not ends with"),

    IS_NULL("не определено", "is null"),
    IS_NOT_NULL("определено", "is not null"),
    IS_EMPTY("пусто", "is empty"),
    IS_NOT_EMPTY("не пусто", "is not empty"),

    IS_TRUE("истина", "is true"),
    IS_FALSE("ложь", "is false"),

    IN("в списке", "in"),
    NOT_IN("не в списке", "not in"),
    BETWEEN("между", "between"),
    NOT_BETWEEN("не между", "not between"),

    BEFORE("до", "before"),
    AFTER("после", "after");

    private final String russianName;

    @Getter
    private final String displayName;

    public String toRussian() {
        return russianName;
    }

    public static Operation of(String key) {
        if (key == null) {
            throw new FilterParseOperationException(null, "Key of filter operation is null, but doesn't expected.");
        }

        key = key.trim();

        for (Operation operation : Operation.values()) {
            if (operation.displayName.equalsIgnoreCase(key) ||
                    operation.russianName.equalsIgnoreCase(key)) {
                return operation;
            }
        }

        throw new FilterParseOperationException(key, "Unknown filter operation.");
    }
}
