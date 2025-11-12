package a.slelin.work.backend.service;

import a.slelin.work.backend.data.dto.PageDto;
import a.slelin.work.backend.data.dto.ReadLevelDto;
import a.slelin.work.backend.data.dto.SaveLevelDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.data.entity.Level;
import a.slelin.work.backend.data.mapper.LevelMapper;
import a.slelin.work.backend.data.repository.LevelRepository;
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
public class LevelService implements CrudService<String, ReadLevelDto, SaveLevelDto> {

    @Autowired
    private LevelMapper mapper;

    @Autowired
    private LevelRepository repo;

    @Override
    @NotNull
    public SheetDto<ReadLevelDto> get(@NotNull @Valid Pageable pageable) {
        Page<Level> page = repo.findAll(pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public SheetDto<ReadLevelDto> getByFilter(@NotNull @Valid FilterChain filter, @NotNull @Valid Pageable pageable) {
        Specification<Level> specification = FilterUtil.toSpecification(filter);

        Page<Level> page = repo.findAll(specification, pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public ReadLevelDto getById(@NotNull String id) {
        Level level = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Level.class, id));

        return mapper.toDTO(level);
    }

    @Override
    @NotNull
    public String save(@NotNull @Valid SaveLevelDto instance) {

        if (repo.existsByName(instance.name())) {
            throw new NotUniqueFieldException(Level.class, "name", instance.name());
        }

        return repo.saveAndFlush(mapper.toEntity(instance)).getCode();
    }

    @Override
    @NotNull
    public ReadLevelDto update(@NotNull String id, @NotNull @Valid SaveLevelDto instance) {
        if (!repo.existsById(id)) {
            throw new EntityNotFoundException(Level.class, id);
        }

        if (repo.existsByNameAndCodeNot(instance.name(), id)) {
            throw new NotUniqueFieldException(Level.class, "name", instance.name());
        }

        Level level = mapper.toEntity(instance);
        level.setCode(id);

        return mapper.toDTO(repo.saveAndFlush(level));
    }

    @Override
    @NotNull
    public ReadLevelDto patch(@NotNull String id, @NotNull @Valid SaveLevelDto instance) {
        Level level = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Level.class, id));

        if (instance.name() != null && repo.existsByNameAndCodeNot(instance.name(), id)) {
            throw new NotUniqueFieldException(Level.class, "name", instance.name());
        }

        mapper.patch(instance, level);

        return mapper.toDTO(repo.saveAndFlush(level));
    }

    @Override
    public void deleteById(@NotNull String id) {
        if (!repo.existsById(id)) {
            throw new EntityNotFoundException(Level.class, id);
        }

        repo.deleteById(id);
    }

    // Custom

    @NotNull
    public SheetDto<ReadLevelDto> getByName(@NotNull String name, @NotNull @Valid Pageable pageable) {
        return get(name, null, pageable);
    }

    @NotNull
    public SheetDto<ReadLevelDto> getBySortOrder(@NotNull Integer sortOrder, @NotNull @Valid Pageable pageable) {
        return get(null, sortOrder, pageable);
    }

    @NotNull
    public SheetDto<ReadLevelDto> get(String name, Integer sortOrder, @NotNull @Valid Pageable pageable) {
        Page<Level> page;

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
