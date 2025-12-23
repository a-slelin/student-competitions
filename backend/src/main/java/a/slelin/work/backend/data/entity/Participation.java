package a.slelin.work.backend.data.entity;

import a.slelin.work.backend.validation.NotBlankNull;
import jakarta.persistence.*;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
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
    @Size(min = 3, max = 100)
    private String supervisor;

    @Min(0)
    private Integer points;

    @Column(columnDefinition = "TEXT")
    @NotBlankNull
    private String description;

    @Column(name = "is_blocked", nullable = false)
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

    // Constructors

    public Participation(UUID id, Student student, Competition competition, Level level, Result result,
                         Integer year, Boolean isBlocked) {
        this(id, student, competition, level, result, year, null, null, null, isBlocked);
    }

    public Participation(UUID id, Student student, Competition competition, Level level, Result result,
                         Integer year) {
        this(id, student, competition, level, result, year, null, null, null, null);
    }

    public Participation(Student student, Competition competition, Level level, Result result,
                         Integer year, Boolean isBlocked) {
        this(null, student, competition, level, result, year, null, null, null, isBlocked);
    }

    public Participation(Student student, Competition competition, Level level, Result result,
                         Integer year) {
        this(null, student, competition, level, result, year, null, null, null, null);
    }

    @Builder
    public Participation(UUID id, Student student, Competition competition, Level level, Result result,
                         Integer year, String supervisor, Integer points, String description, Boolean isBlocked) {
        this.id = id;
        this.student = student;
        this.competition = competition;
        this.level = level;
        this.result = result;
        this.year = year;
        this.supervisor = supervisor;
        this.points = points;
        this.description = description;
        this.isBlocked = isBlocked;
    }

    // Callbacks

    @PrePersist
    @Override
    protected void prePersist() {
        super.prePersist();
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
