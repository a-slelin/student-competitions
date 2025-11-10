package a.slelin.work.backend.data.entity;

import lombok.Getter;

public enum Faculty {
    BIOLOGY("Факультет биологии и экологии", "Faculty of Biology and Ecology"),
    IT("Факультет информатики и вычислительной техники", "Faculty of Computer Science and Engineering"),
    HISTORY("Исторический факультет", "Faculty of History"),
    MATH("Математический факультет", "Faculty of Mathematics"),
    PSYCHO("Факультет психологии", "Faculty of Psychology"),
    SOCIO_POLITICAL("Факультет социально-политических наук", "Faculty of Social and Political Sciences"),
    LANGUAGES("Факультет иностранных языков", "Faculty of Foreign Languages"),
    PHYSIC("Физико-технический факультет", "Faculty of Physics and Technology"),
    PHILOLOGY("Факультет филологии и коммуникации", "Faculty of Philology and Communication"),
    ECONOMIC("Экономический факультет", "Faculty of Economics"),
    LAW("Юридический факультет", "Faculty of Law");

    private final String russianName;

    @Getter
    private final String displayName;

    Faculty(String russianName, String displayName) {
        this.russianName = russianName;
        this.displayName = displayName;
    }

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

    public static String toRussian(Faculty faculty) {
        return faculty.russianName;
    }
}
