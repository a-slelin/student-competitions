package a.slelin.work.backend.service;

import a.slelin.work.backend.data.dto.PageDto;
import a.slelin.work.backend.data.dto.ReadResultDto;
import a.slelin.work.backend.data.dto.SaveResultDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.data.entity.Result;
import a.slelin.work.backend.data.mapper.ResultMapper;
import a.slelin.work.backend.data.repository.ResultRepository;
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

@Service
@Transactional
@Validated
public class ResultService implements CrudService<String, ReadResultDto, SaveResultDto> {

    @Autowired
    private ResultMapper mapper;

    @Autowired
    private ResultRepository repo;

    @Override
    @NotNull
    public SheetDto<ReadResultDto> get(@NotNull @Valid Pageable pageable) {
        Page<Result> page = repo.findAll(pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public SheetDto<ReadResultDto> getByFilter(@NotNull @Valid FilterChain filter, @NotNull @Valid Pageable pageable) {
        Specification<Result> specification = FilterUtil.toSpecification(filter);

        Page<Result> page = repo.findAll(specification, pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public ReadResultDto getById(@NotNull String id) {
        Result result = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Result.class, id));

        return mapper.toDTO(result);
    }

    @Override
    @NotNull
    public String save(@NotNull @Valid SaveResultDto instance) {
        if (repo.existsByName(instance.name())) {
            throw new NotUniqueFieldException(Result.class, "name", instance.name());
        }

        return repo.saveAndFlush(mapper.toEntity(instance)).getCode();
    }

    @Override
    @NotNull
    public ReadResultDto update(@NotNull String id, @NotNull @Valid SaveResultDto instance) {
        if (repo.existsById(id)) {
            throw new EntityNotFoundException(Result.class, id);
        }

        if (!repo.existsByNameAndIdNot(instance.name(), id)) {
            throw new NotUniqueFieldException(Result.class, "name", instance.name());
        }

        Result result = mapper.toEntity(instance);
        result.setCode(id);

        return mapper.toDTO(repo.saveAndFlush(result));
    }

    @Override
    @NotNull
    public ReadResultDto patch(@NotNull String id, @NotNull @Valid SaveResultDto instance) {
        Result result = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Result.class, id));

        if (instance.name() != null && repo.existsByNameAndIdNot(instance.name(), id)) {
            throw new NotUniqueFieldException(Result.class, "name", instance.name());
        }

        mapper.patch(instance, result);

        return mapper.toDTO(repo.saveAndFlush(result));
    }

    @Override
    public void deleteById(@NotNull String id) {
        if (!repo.existsById(id)) {
            throw new EntityNotFoundException(Result.class, id);
        }

        repo.deleteById(id);
    }

    // Custom

    @NotNull
    public SheetDto<ReadResultDto> getByName(@NotNull String name, @NotNull @Valid Pageable pageable) {
        return get(name, null, pageable);
    }

    @NotNull
    public SheetDto<ReadResultDto> getBySortOrder(@NotNull Integer sortOrder, @Valid Pageable pageable) {
        return get(null, sortOrder, pageable);
    }

    @NotNull
    public SheetDto<ReadResultDto> get(String name, Integer sortOrder, @NotNull @Valid Pageable pageable) {
        Page<Result> page;

        if (name == null) {
            if (sortOrder == null) {
                page = repo.findAll(pageable);
            } else {
                page = repo.findAllBySortOrder(sortOrder, pageable);
            }
        } else {
            if (sortOrder == null) {
                page = repo.findAllByNameContaining(name, pageable);
            } else {
                page = repo.findAllBySortOrderAndNameContaining(sortOrder, name, pageable);
            }
        }

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

}
