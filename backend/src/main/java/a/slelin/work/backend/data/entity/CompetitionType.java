package a.slelin.work.backend.data.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
public enum CompetitionType {
    OLYMPIAD("Олимпиада", "Olympiad"),
    CONTEST("Состязание", "Contest"),
    CHAMPIONSHIP("Чемпионат", "Championship"),
    COMPETITION("Соревнование", "Competition");

    private final String russianName;

    @Getter
    private final String displayName;

    public String toRussian() {
        return russianName;
    }

    public static CompetitionType fromRussian(String russianName) {
        if (russianName == null) {
            throw new IllegalArgumentException("Competition type should be not null");
        }

        russianName = russianName.trim();

        for (CompetitionType type : values()) {
            if (type.russianName.equalsIgnoreCase(russianName)) {
                return type;
            }
        }

        throw new IllegalArgumentException("Unknown competition type: " + russianName);
    }

    public static CompetitionType from(String value) {
        if (value == null) {
            throw new IllegalArgumentException("Competition type should be not null.");
        }

        value = value.trim();

        for (CompetitionType type : values()) {
            if (type.russianName.equalsIgnoreCase(value) ||
                    type.displayName.equalsIgnoreCase(value)) {
                return type;
            }
        }

        throw new IllegalArgumentException("Unknown competition type: " + value);
    }
}
