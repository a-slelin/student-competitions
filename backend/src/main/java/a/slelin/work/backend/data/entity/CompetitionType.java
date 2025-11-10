package a.slelin.work.backend.data.entity;

import lombok.Getter;

public enum CompetitionType {
    OLYMPIAD("Олимпиада", "Olympiad"),
    CONTEST("Состязание", "Contest"),
    CHAMPIONSHIP("Чемпионат", "Championship"),
    COMPETITION("Соревнование", "Competition");

    private final String russianName;

    @Getter
    private final String displayName;

    CompetitionType(String russianName, String displayName) {
        this.russianName = russianName;
        this.displayName = displayName;
    }

    public String toRussian() {
        return russianName;
    }
}
