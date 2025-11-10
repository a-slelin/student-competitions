package a.slelin.work.backend.service;

import a.slelin.work.backend.data.dto.PageDto;
import a.slelin.work.backend.data.dto.ReadCompetitionDto;
import a.slelin.work.backend.data.dto.SaveCompetitionDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.data.entity.Competition;
import a.slelin.work.backend.data.entity.Student;
import a.slelin.work.backend.data.mapper.CompetitionMapper;
import a.slelin.work.backend.data.repository.CompetitionRepository;
import a.slelin.work.backend.exception.EntityNotFoundException;
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
public class CompetitionService implements CrudService<UUID, ReadCompetitionDto, SaveCompetitionDto> {

    @Autowired
    private CompetitionMapper mapper;

    @Autowired
    private CompetitionRepository repo;

    @Override
    @NotNull
    public SheetDto<ReadCompetitionDto> get(@NotNull @Valid Pageable pageable) {
        Page<Competition> page = repo.findAll(pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public SheetDto<ReadCompetitionDto> getByFilter(@NotNull @Valid FilterChain filter, @NotNull @Valid Pageable pageable) {
        Specification<Competition> specification = FilterUtil.toSpecification(filter);

        Page<Competition> page = repo.findAll(specification, pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public ReadCompetitionDto getById(@NotNull UUID id) {
        Competition competition = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Competition.class, id));

        return mapper.toDTO(competition);
    }

    @Override
    @NotNull
    public UUID save(@NotNull @Valid SaveCompetitionDto instance) {
        return repo.saveAndFlush(mapper.toEntity(instance)).getId();
    }

    @Override
    @NotNull
    public ReadCompetitionDto update(@NotNull UUID id, @NotNull @Valid SaveCompetitionDto instance) {
        if (!repo.existsById(id)) {
            throw new EntityNotFoundException(Competition.class, id);
        }

        Competition competition = mapper.toEntity(instance);
        competition.setId(id);

        return mapper.toDTO(repo.saveAndFlush(competition));
    }

    @Override
    @NotNull
    public ReadCompetitionDto patch(@NotNull UUID id, @NotNull @Valid SaveCompetitionDto instance) {
        Competition competition = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Competition.class, id));

        mapper.patch(instance, competition);

        return mapper.toDTO(repo.saveAndFlush(competition));
    }

    @Override
    public void deleteById(UUID id) {
        if (!repo.existsById(id)) {
            throw new EntityNotFoundException(Competition.class, id);
        }

        repo.deleteById(id);
    }
}
