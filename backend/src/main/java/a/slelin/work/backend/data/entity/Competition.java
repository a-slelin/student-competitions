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
@AllArgsConstructor
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
                
                """.formatted(id, name, organizer, type, super.toString());
    }
}
