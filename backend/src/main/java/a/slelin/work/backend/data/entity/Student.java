package a.slelin.work.backend.data.entity;

import a.slelin.work.backend.validation.NotBlankNull;
import a.slelin.work.backend.validation.Phone;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = Student.ENTITY_NAME)
@Table(name = Student.TABLE_NAME)
public class Student extends Audit implements BaseEntity {

    // Static fields

    public static final String ENTITY_NAME = "student";

    public static final String TABLE_NAME = "student";

    // Fields

    @Id
    @GeneratedValue(generator = "UUID")
    private UUID id;

    @Column(length = 50, nullable = false)
    @NotBlank
    @Size(min = 3, max = 50)
    private String name;

    @Column(length = 50, nullable = false)
    @NotBlank
    @Size(min = 3, max = 50)
    private String surname;

    @Column(length = 50, name = "middle_name")
    @Size(min = 3, max = 50)
    private String middleName;

    @Column(unique = true,
            name = "card_number",
            nullable = false)
    @Min(0)
    @NotNull
    private Long cardNumber;

    @Column(length = 50, nullable = false)
    @NotNull
    private Faculty faculty;

    @Column(length = 20)
    @NotBlankNull
    @Size(min = 3, max = 20)
    private String department;

    @Column(length = 50, name = "study_group")
    @NotBlankNull
    @Size(min = 3, max = 50)
    private String studyGroup;

    @Column(length = 100)
    @Email
    @Size(min = 3, max = 100)
    private String email;

    @Column(length = 20)
    @Phone
    @Size(min = 3, max = 20)
    private String phone;

    @OneToMany(mappedBy = "student", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Participation> participations = new ArrayList<>();

    // Constructors

    public Student(UUID id, String name, String surname, Long cardNumber, Faculty faculty) {
        this(id, name, surname, null, cardNumber, faculty, null, null, null, null);
    }

    public Student(String name, String surname, Long cardNumber, Faculty faculty) {
        this(null, name, surname, null, cardNumber, faculty, null, null, null, null);
    }

    @Builder
    public Student(UUID id, String name, String surname, String middleName, Long cardNumber,
                   Faculty faculty, String department, String studyGroup, String email, String phone) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.middleName = middleName;
        this.cardNumber = cardNumber;
        this.faculty = faculty;
        this.department = department;
        this.studyGroup = studyGroup;
        this.email = email;
        this.phone = phone;
    }

    // Methods

    @Override
    public String toString() {
        return """
                
                Student:
                    id = %s,
                    name = %s,
                    surname = %s,
                    middleName = %s,
                    cardNumber = %d,
                    faculty = %s,
                    department = %s,
                    studyGroup = %s,
                    email = %s,
                    phone = %s.
                    %s
                
                """.formatted(id, name, surname, middleName, cardNumber, faculty.getDisplayName(),
                department, studyGroup, email, phone, super.toString());
    }

    public String toShortString() {
        return "(id = %s, cardNumber = %s)".formatted(id, cardNumber);
    }
}
