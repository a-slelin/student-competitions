package a.slelin.work.backend.data.entity;

import a.slelin.work.backend.validation.NotBlankNull;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = Competition.ENTITY_NAME)
@Table(name = Competition.TABLE_NAME)
public class Competition extends Audit implements BaseEntity {

    // Static fields

    public static final String ENTITY_NAME = "competition";

    public static final String TABLE_NAME = "competition";

    // Fields

    @Id
    @GeneratedValue(generator = "UUID")
    private UUID id;

    @Column(nullable = false)
    @NotBlank
    private String name;

    @NotBlankNull
    private String organizer;

    @Column(length = 50)
    @NotNull
    @Enumerated(EnumType.STRING)
    private CompetitionType type;

    // Constructors

    public Competition(UUID id, String name, CompetitionType type) {
        this(id, name, null, type);
    }

    public Competition(String name, CompetitionType type) {
        this(null, name, null, type);
    }

    @Builder
    public Competition(UUID id, String name, String organizer, CompetitionType type) {
        this.id = id;
        this.name = name;
        this.organizer = organizer;
        this.type = type;
    }

    // Methods

    @Override
    public String toString() {
        return """
                
                Competition:
                    id = %s,
                    name = %s,
                    organizer = %s,
                    type = %s.
                    %s
                
                """.formatted(id, name, organizer, type.getDisplayName(), super.toString());
    }

    public String toShortString() {
        return "(id = %s, name = %s)".formatted(id, name);
    }
}
