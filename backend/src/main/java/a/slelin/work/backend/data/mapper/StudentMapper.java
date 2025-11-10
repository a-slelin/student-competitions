package a.slelin.work.backend.data.mapper;

import a.slelin.work.backend.data.dto.ReadStudentDto;
import a.slelin.work.backend.data.dto.SaveStudentDto;
import a.slelin.work.backend.data.entity.Faculty;
import a.slelin.work.backend.data.entity.Student;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;

@Component
@Validated
public class StudentMapper implements Mapper<Student, ReadStudentDto, SaveStudentDto> {

    @Override
    @NotNull
    public ReadStudentDto toDTO(@NotNull @Valid Student entity) {
        return ReadStudentDto.builder()
                .id(entity.getId().toString())
                .name(entity.getName())
                .surname(entity.getSurname())
                .middleName(entity.getMiddleName())
                .faculty(entity.getFaculty().toRussian())
                .department(entity.getDepartment())
                .studyGroup(entity.getStudyGroup())
                .email(entity.getEmail())
                .phone(entity.getPhone())
                .build();
    }

    @Override
    @NotNull
    public Student toEntity(@NotNull @Valid SaveStudentDto dto) {
        return Student.builder()
                .name(dto.name())
                .surname(dto.surname())
                .middleName(dto.middleName())
                .cardNumber(dto.cardNumber())
                .faculty(Faculty.fromRussian(dto.faculty()))
                .department(dto.department())
                .studyGroup(dto.studyGroup())
                .email(dto.email())
                .phone(dto.phone())
                .build();
    }

    @Override
    public void patch(@NotNull @Valid SaveStudentDto dto, @NotNull @Valid Student entity) {
        if (dto.name() != null) {
            entity.setName(dto.name());
        }

        if (dto.surname() != null) {
            entity.setSurname(dto.surname());
        }

        if (dto.middleName() != null) {
            entity.setMiddleName(dto.middleName());
        }

        if (dto.cardNumber() != null) {
            entity.setCardNumber(dto.cardNumber());
        }

        if (dto.faculty() != null) {
            entity.setFaculty(Faculty.fromRussian(dto.faculty()));
        }

        if (dto.department() != null) {
            entity.setDepartment(dto.department());
        }

        if (dto.studyGroup() != null) {
            entity.setDepartment(dto.department());
        }

        if (dto.email() != null) {
            entity.setEmail(dto.email());
        }

        if (dto.phone() != null) {
            entity.setPhone(dto.phone());
        }
    }
}
