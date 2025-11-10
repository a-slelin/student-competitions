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
            throw new IllegalArgumentException("Competition type is not null");
        }

        for (CompetitionType type : values()) {
            if (type.russianName.equals(russianName)) {
                return type;
            }
        }

        throw new IllegalArgumentException("Unknown competition type: " + russianName);
    }
}
