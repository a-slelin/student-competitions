package a.slelin.work.backend.data.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
public enum Faculty {
    BIOLOGY("Факультет биологии и экологии", "Faculty of Biology and Ecology"),
    COMPUTER_SCIENCE("Факультет информатики и вычислительной техники", "Faculty of Computer Science and Engineering"),
    HISTORY("Исторический факультет", "Faculty of History"),
    MATHEMATICS("Математический факультет", "Faculty of Mathematics"),
    PSYCHOLOGY("Факультет психологии", "Faculty of Psychology"),
    SOCIAL_POLITICAL("Факультет социально-политических наук", "Faculty of Social and Political Sciences"),
    LANGUAGES("Факультет иностранных языков", "Faculty of Foreign Languages"),
    PHYSICS("Физико-технический факультет", "Faculty of Physics and Technology"),
    PHILOLOGY_COMMUNICATION("Факультет филологии и коммуникации", "Faculty of Philology and Communication"),
    ECONOMICS("Экономический факультет", "Faculty of Economics"),
    LAW("Юридический факультет", "Faculty of Law");

    private final String russianName;

    @Getter
    private final String displayName;

    public String toRussian() {
        return russianName;
    }

    public static Faculty fromRussian(String russianName) {
        if (russianName == null) {
            throw new IllegalArgumentException("Faculty should be not null");
        }

        russianName = russianName.trim();

        for (Faculty faculty : values()) {
            if (faculty.russianName.equalsIgnoreCase(russianName)) {
                return faculty;
            }
        }

        throw new IllegalArgumentException("Unknown faculty: " + russianName);
    }

    public static Faculty from(String value) {
        if (value == null) {
            throw new IllegalArgumentException("Faculty should be not null");
        }

        value = value.trim();

        for (Faculty faculty : values()) {
            if (faculty.russianName.equalsIgnoreCase(value) ||
                    faculty.displayName.equalsIgnoreCase(value)) {
                return faculty;
            }
        }

        throw new IllegalArgumentException("Unknown faculty: " + value);
    }
}
