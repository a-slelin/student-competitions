package a.slelin.work.backend.data.entity;

import a.slelin.work.backend.validation.NotBlankNull;
import a.slelin.work.backend.validation.Phone;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Entity(name = Student.ENTITY_NAME)
@Table(name = Student.TABLE_NAME)
public class Student extends Audit {

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
    private String department;

    @Column(length = 50, name = "study_group")
    @NotBlankNull
    private String studyGroup;

    @Column(length = 100)
    @Email
    private String email;

    @Column(length = 20)
    @Phone
    private String phone;

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
                
                """.formatted(id, name, surname, middleName, cardNumber, faculty,
                department, studyGroup, email, phone, super.toString());
    }
}
