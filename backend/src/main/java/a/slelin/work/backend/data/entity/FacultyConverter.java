package a.slelin.work.backend.data.entity;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class FacultyConverter implements AttributeConverter<Faculty, String> {

    @Override
    public String convertToDatabaseColumn(Faculty faculty) {
        return faculty.toRussian();
    }

    @Override
    public Faculty convertToEntityAttribute(String faculty) {
        return Faculty.fromRussian(faculty);
    }
}
