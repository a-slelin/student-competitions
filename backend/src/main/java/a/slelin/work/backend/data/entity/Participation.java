package a.slelin.work.backend.data.entity;

import a.slelin.work.backend.validation.NotBlankNull;
import jakarta.persistence.*;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Entity(name = Participation.ENTITY_NAME)
@Table(
        name = Participation.TABLE_NAME,
        uniqueConstraints = {
                @UniqueConstraint(columnNames = {"student_id", "competition_id", "year"})
        }
)
public class Participation extends Audit implements BaseEntity {

    // Static fields

    public static final String ENTITY_NAME = "participation";

    public static final String TABLE_NAME = "participation";

    // Fields

    @Id
    @GeneratedValue(generator = "UUID")
    private UUID id;

    @Column(nullable = false)
    @NotNull
    @Min(0)
    private Integer year;

    @Column(length = 100)
    @NotBlankNull
    private String supervisor;

    @Min(0)
    private Integer points;

    @Lob
    @NotBlankNull
    private String description;

    @Column(name = "is_blocked", nullable = false)
    @NotNull
    private Boolean isBlocked;

    // Relationships

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "student_id", nullable = false)
    @NotNull
    @Valid
    private Student student;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "competition_id", nullable = false)
    @NotNull
    @Valid
    private Competition competition;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "level_code", nullable = false)
    @NotNull
    @Valid
    private Level level;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @JoinColumn(name = "result_code", nullable = false)
    @NotNull
    @Valid
    private Result result;

    // Callbacks

    @PrePersist
    private void prePersist() {
        if (isBlocked == null) {
            isBlocked = Boolean.FALSE;
        }
    }

    // Methods

    @Override
    public String toString() {
        return """
                
                Participation:
                    id = %s,
                    student = %s,
                    competition = %s,
                    level = %s,
                    result = %s,
                    year = %s,
                    supervisor = %s,
                    points = %s,
                    description = %s,
                    isBlocked = %s.
                    %s
                
                """.formatted(id, student.toShortString(), competition.toShortString(),
                level.toShortString(), result.toShortString(), year, supervisor,
                points, description, isBlocked, super.toString());
    }
}
