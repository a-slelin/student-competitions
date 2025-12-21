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
@Entity(name = Level.ENTITY_NAME)
@Table(name = Level.TABLE_NAME)
public class Level implements BaseEntity {

    // Static fields

    public static final String ENTITY_NAME = "level";

    public static final String TABLE_NAME = "level";

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

    @OneToMany(mappedBy = "level", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Participation> participations = new ArrayList<>();

    // Methods

    @Builder
    public Level(String code, String name, Integer sortOrder) {
        this.code = code;
        this.name = name;
        this.sortOrder = sortOrder;
    }

    @Override
    public String toString() {
        return """
                
                Level:
                    code = %s,
                    name = %s,
                    sortOrder = %d.
                
                """.formatted(code, name, sortOrder);
    }

    public String toShortString() {
        return "(code = %s, name = %s)".formatted(code, name);
    }
}
