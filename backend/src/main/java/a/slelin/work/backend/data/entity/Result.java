package a.slelin.work.backend.data.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Entity(name = Result.ENTITY_NAME)
@Table(name = Result.TABLE_NAME)
public class Result {

    // Static fields

    public static final String ENTITY_NAME = "result";

    public static final String TABLE_NAME = "result";

    // Fields

    @Id
    @Column(length = 20)
    @Size(min = 3, max = 20)
    @NotNull
    @Pattern(regexp = "^[A-Z]+$")
    private String code;

    @Column(unique = true,
            nullable = false,
            length = 50)
    @Size(min = 3, max = 50)
    @NotBlank
    private String name;

    @Column(nullable = false, name = "sort_order")
    @NotNull
    @Min(0)
    private Integer sortOrder;

    // Methods

    @Override
    public String toString() {
        return """
                
                Result:
                    code = %s,
                    name = %s,
                    sortOrder = %d.
                
                """.formatted(code, name, sortOrder);
    }

    public String toShortString() {
        return "(code = %s, name = %s)".formatted(code, name);
    }
}
