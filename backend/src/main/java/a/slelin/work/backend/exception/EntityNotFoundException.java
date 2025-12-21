package a.slelin.work.backend.exception;

import a.slelin.work.backend.data.entity.BaseEntity;
import lombok.Getter;

@Getter
public class EntityNotFoundException extends RuntimeException {

    private final Class<? extends BaseEntity> clazz;

    private final String field;

    private final Object value;

    public EntityNotFoundException(Class<? extends BaseEntity> clazz, String field, Object value) {
        super("Entity \"" + clazz.getSimpleName()
                + "\" not found by field = \"" + field
                + "\" with value = \"" + value.toString() + "\".");

        this.clazz = clazz;
        this.field = field;
        this.value = value;
    }

    public EntityNotFoundException(Class<? extends BaseEntity> clazz, Object value) {
        this(clazz, "id", value);
    }
}

