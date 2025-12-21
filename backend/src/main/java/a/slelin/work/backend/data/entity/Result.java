package a.slelin.work.backend.data.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = Result.ENTITY_NAME)
@Table(name = Result.TABLE_NAME)
public class Result implements BaseEntity {

    // Static fields

    public static final String ENTITY_NAME = "result";

    public static final String TABLE_NAME = "result";

    // Fields

    @Id
    @Column(length = 20)
    @Size(min = 3, max = 20)
    @Pattern(regexp = "^[A-Z]+$")
    @NotNull
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

    @OneToMany(mappedBy = "result", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Participation> participations = new ArrayList<>();

    // Methods

    @Builder
    public Result(String code, String name, Integer sortOrder) {
        this.code = code;
        this.name = name;
        this.sortOrder = sortOrder;
    }

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
