package a.slelin.work.backend.data.entity;

import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import lombok.AccessLevel;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@MappedSuperclass
@Getter
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED, force = true)
public class Audit {

    // Static Fields

    public final static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss");

    // Fields

    @Column(name = "created_at",
            nullable = false,
            updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    // Methods

    @Override
    public String toString() {
        return """
                Audit:
                    \tcreatedAt = %s,
                    \tupdateAt = %s.
                
                """.formatted(createdAt == null ? null : createdAt.format(formatter),
                updatedAt == null ? null : updatedAt.format(formatter));
    }
}
