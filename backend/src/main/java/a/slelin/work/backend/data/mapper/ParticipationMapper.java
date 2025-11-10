package a.slelin.work.backend.data.mapper;

import a.slelin.work.backend.controller.ControllerConfig;
import a.slelin.work.backend.data.dto.ReadParticipationDto;
import a.slelin.work.backend.data.dto.SaveParticipationDto;
import a.slelin.work.backend.data.entity.*;
import a.slelin.work.backend.data.repository.CompetitionRepository;
import a.slelin.work.backend.data.repository.LevelRepository;
import a.slelin.work.backend.data.repository.ResultRepository;
import a.slelin.work.backend.data.repository.StudentRepository;
import a.slelin.work.backend.exception.EntityNotFoundException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.annotation.Validated;

import java.net.URI;
import java.util.UUID;

@Component
@Validated
public class ParticipationMapper implements Mapper<Participation, ReadParticipationDto, SaveParticipationDto> {

    @Autowired
    private ControllerConfig config;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private CompetitionRepository competitionRepository;

    @Autowired
    private LevelRepository levelRepository;

    @Autowired
    private ResultRepository resultRepository;

    @Override
    @NotNull
    public ReadParticipationDto toDTO(@NotNull @Valid Participation entity) {
        return ReadParticipationDto.builder()
                .id(entity.getId().toString())
                .student(
                        URI.create("%s/%s".formatted(config.getStudentUri(),
                                entity.getStudent().getId().toString()))
                )
                .competition(
                        URI.create("%s/%s".formatted(config.getCompetitionUri(),
                                entity.getCompetition().getId().toString()))
                )
                .level(
                        URI.create("%s/%s".formatted(config.getLevelUri(),
                                entity.getLevel().getCode()))
                )
                .result(
                        URI.create("%s/%s".formatted(config.getResultUri(),
                                entity.getResult().getCode()))
                )
                .year(entity.getYear())
                .supervisor(entity.getSupervisor())
                .points(entity.getPoints())
                .description(entity.getDescription())
                .isBlocked(entity.getIsBlocked())
                .build();
    }

    @Override
    @NotNull
    public Participation toEntity(@NotNull @Valid SaveParticipationDto dto) {
        return Participation.builder()
                .student(
                        studentRepository.findById(UUID.fromString(dto.student()))
                                .orElseThrow(() -> new EntityNotFoundException(Student.class, dto.student()))
                )
                .competition(
                        competitionRepository.findById(UUID.fromString(dto.competition()))
                                .orElseThrow(() -> new EntityNotFoundException(Competition.class, dto.competition()))
                )
                .level(
                        levelRepository.findById(dto.level())
                                .orElseThrow(() -> new EntityNotFoundException(Level.class, dto.level()))
                )
                .result(
                        resultRepository.findById(dto.result())
                                .orElseThrow(() -> new EntityNotFoundException(Result.class, dto.result()))
                )
                .year(dto.year())
                .supervisor(dto.supervisor())
                .points(dto.points())
                .description(dto.description())
                .build();
    }

    @Override
    public void patch(@NotNull @Valid SaveParticipationDto dto, @NotNull @Valid Participation entity) {
        if (dto.student() != null) {
            Student student = studentRepository.findById(UUID.fromString(dto.student()))
                    .orElseThrow(() -> new EntityNotFoundException(Student.class, dto.student()));

            entity.setStudent(student);
        }

        if (dto.competition() != null) {
            Competition competition = competitionRepository.findById(UUID.fromString(dto.competition()))
                    .orElseThrow(() -> new EntityNotFoundException(Competition.class, dto.competition()));

            entity.setCompetition(competition);
        }

        if (dto.level() != null) {
            Level level = levelRepository.findById(dto.level())
                    .orElseThrow(() -> new EntityNotFoundException(Level.class, dto.level()));

            entity.setLevel(level);
        }

        if (dto.result() != null) {
            Result result = resultRepository.findById(dto.result())
                    .orElseThrow(() -> new EntityNotFoundException(Result.class, dto.result()));

            entity.setResult(result);
        }

        if (dto.year() != null) {
            entity.setYear(dto.year());
        }

        if (dto.supervisor() != null) {
            entity.setSupervisor(dto.supervisor());
        }

        if (dto.points() != null) {
            entity.setPoints(dto.points());
        }

        if (dto.description() != null) {
            entity.setDescription(dto.description());
        }
    }
}
