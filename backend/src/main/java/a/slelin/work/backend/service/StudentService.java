package a.slelin.work.backend.service;

import a.slelin.work.backend.data.dto.PageDto;
import a.slelin.work.backend.data.dto.ReadStudentDto;
import a.slelin.work.backend.data.dto.SaveStudentDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.data.entity.Student;
import a.slelin.work.backend.data.mapper.StudentMapper;
import a.slelin.work.backend.data.repository.StudentRepository;
import a.slelin.work.backend.exception.EntityNotFoundException;
import a.slelin.work.backend.exception.NotUniqueFieldException;
import a.slelin.work.backend.filter.FilterChain;
import a.slelin.work.backend.filter.FilterUtil;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;

import java.util.UUID;

@Service
@Transactional
@Validated
public class StudentService implements CrudService<UUID, ReadStudentDto, SaveStudentDto> {

    @Autowired
    private StudentMapper mapper;

    @Autowired
    private StudentRepository repo;

    @Override
    @NotNull
    public SheetDto<ReadStudentDto> get(@NotNull @Valid Pageable pageable) {
        Page<Student> page = repo.findAll(pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public SheetDto<ReadStudentDto> getByFilter(@NotNull @Valid FilterChain filter, @NotNull @Valid Pageable pageable) {
        Specification<Student> specification = FilterUtil.toSpecification(filter);

        Page<Student> page = repo.findAll(specification, pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public ReadStudentDto getById(@NotNull UUID id) {
        Student student = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Student.class, id));

        return mapper.toDTO(student);
    }

    @Override
    @NotNull
    public UUID save(@NotNull @Valid SaveStudentDto instance) {
        if (repo.existsByCardNumber(instance.cardNumber())) {
            throw new NotUniqueFieldException(Student.class, "cardNumber", instance.cardNumber());
        }

        return repo.saveAndFlush(mapper.toEntity(instance)).getId();
    }

    @Override
    @NotNull
    public ReadStudentDto update(@NotNull UUID id, @NotNull @Valid SaveStudentDto instance) {
        if (!repo.existsById(id)) {
            throw new EntityNotFoundException(Student.class, id);
        }

        if (repo.existsByCardNumberAndIdNot(instance.cardNumber(), id)) {
            throw new NotUniqueFieldException(Student.class, "cardNumber", instance.cardNumber());
        }

        Student student = mapper.toEntity(instance);
        student.setId(id);

        return mapper.toDTO(repo.saveAndFlush(student));
    }

    @Override
    @NotNull
    public ReadStudentDto patch(@NotNull UUID id, @NotNull @Valid SaveStudentDto instance) {
        Student student = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Student.class, id));

        if (instance.cardNumber() != null && repo.existsByCardNumberAndIdNot(instance.cardNumber(), id)) {
            throw new NotUniqueFieldException(Student.class, "cardNumber", instance.cardNumber());
        }

        mapper.patch(instance, student);

        return mapper.toDTO(repo.saveAndFlush(student));
    }

    @Override
    public void deleteById(@NotNull UUID id) {
        if (!repo.existsById(id)) {
            throw new EntityNotFoundException(Student.class, id);
        }

        repo.deleteById(id);
    }
}
