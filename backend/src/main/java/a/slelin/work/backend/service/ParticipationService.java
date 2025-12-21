package a.slelin.work.backend.service;

import a.slelin.work.backend.data.dto.PageDto;
import a.slelin.work.backend.data.dto.ReadParticipationDto;
import a.slelin.work.backend.data.dto.SaveParticipationDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.data.entity.Participation;
import a.slelin.work.backend.data.mapper.ParticipationMapper;
import a.slelin.work.backend.data.repository.ParticipationRepository;
import a.slelin.work.backend.exception.EditBlockedParticipationException;
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
public class ParticipationService implements CrudService<UUID, ReadParticipationDto, SaveParticipationDto> {

    @Autowired
    private ParticipationMapper mapper;

    @Autowired
    private ParticipationRepository repo;

    @Override
    @NotNull
    public SheetDto<ReadParticipationDto> get(@NotNull @Valid Pageable pageable) {
        Page<Participation> page = repo.findAll(pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public SheetDto<ReadParticipationDto> getByFilter(@NotNull @Valid FilterChain filter, @NotNull @Valid Pageable pageable) {
        Specification<Participation> specification = FilterUtil.toSpecification(filter);

        Page<Participation> page = repo.findAll(specification, pageable);

        return new SheetDto<>(page.stream().map(mapper::toDTO).toList(),
                PageDto.of(page));
    }

    @Override
    @NotNull
    public ReadParticipationDto getById(@NotNull UUID id) {
        Participation participation = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Participation.class, id));

        return mapper.toDTO(participation);
    }

    @Override
    @NotNull
    public UUID save(@NotNull @Valid SaveParticipationDto instance) {
        return repo.saveAndFlush(mapper.toEntity(instance)).getId();
    }

    @Override
    @NotNull
    public ReadParticipationDto update(@NotNull UUID id, @NotNull @Valid SaveParticipationDto instance) {
        Participation participation = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Participation.class, id));

        if (participation.getIsBlocked()) {
            throw new EditBlockedParticipationException(id);
        }

        Participation participation2 = mapper.toEntity(instance);
        participation.setId(id);

        return mapper.toDTO(repo.saveAndFlush(participation2));
    }

    @Override
    @NotNull
    public ReadParticipationDto patch(@NotNull UUID id, @NotNull @Valid SaveParticipationDto instance) {
        Participation participation = repo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException(Participation.class, id));

        if (participation.getIsBlocked()) {
            throw new EditBlockedParticipationException(id);
        }

        mapper.patch(instance, participation);

        return mapper.toDTO(repo.saveAndFlush(participation));
    }

    @Override
    public void deleteById(@NotNull UUID id) {
        if (!repo.existsById(id)) {
            throw new EntityNotFoundException(Participation.class, id);
        }

        repo.deleteById(id);
    }
}
