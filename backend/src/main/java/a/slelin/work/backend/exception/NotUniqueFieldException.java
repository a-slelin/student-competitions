package a.slelin.work.backend.exception;

import a.slelin.work.backend.data.entity.BaseEntity;
import lombok.Getter;

@Getter
public class NotUniqueFieldException extends RuntimeException {

    private final Class<? extends BaseEntity> clazz;

    private final String field;

    private final Object value;

    public NotUniqueFieldException(Class<? extends BaseEntity> clazz, String field, Object value) {
        super("Field \"" + field + "\" from entity \"" + clazz.getSimpleName()
                + "\" with value \"" + value.toString() + "\" is not unique, but doesn't expected.");

        this.clazz = clazz;
        this.field = field;
        this.value = value;
    }
}
