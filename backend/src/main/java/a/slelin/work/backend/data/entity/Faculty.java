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
            throw new IllegalArgumentException("Faculty is not null");
        }

        for (Faculty faculty : values()) {
            if (faculty.russianName.equals(russianName)) {
                return faculty;
            }
        }

        throw new IllegalArgumentException("Unknown faculty: " + russianName);
    }
}
