package a.slelin.work.backend.controller;

import a.slelin.work.backend.data.dto.ReadCompetitionDto;
import a.slelin.work.backend.data.dto.SaveCompetitionDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.data.entity.Competition;
import a.slelin.work.backend.filter.FilterChain;
import a.slelin.work.backend.service.CompetitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.UUID;

@RestController
@RequestMapping("/${api.api-prefix}/${api.competition-prefix}")
public class CompetitionController {

    @Autowired
    private ControllerConfig config;

    @Autowired
    private CompetitionService service;

    @GetMapping(produces = "application/json")
    public ResponseEntity<SheetDto<ReadCompetitionDto>> get(@PageableDefault Pageable pageable) {
        return ResponseEntity.ok(service.get(pageable));
    }

    @GetMapping(path = "/{id}", produces = "application/json")
    public ResponseEntity<ReadCompetitionDto> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.getById(id));
    }

    @PostMapping(path = "/${api.search-prefix}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<SheetDto<ReadCompetitionDto>> search(@RequestBody FilterChain filter,
                                                               @PageableDefault Pageable pageable) {
        return ResponseEntity.ok(service.getByFilter(filter, pageable));
    }

    @PostMapping(consumes = "application/json")
    public ResponseEntity<Void> create(@RequestBody SaveCompetitionDto instance) {
        UUID id = service.save(instance);

        URI location = URI.create(config.getCompetitionUri() + "/" + id.toString());

        return ResponseEntity.created(location).build();
    }

    @PutMapping(path = "/{id}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ReadCompetitionDto> update(@PathVariable UUID id,
                                                     @RequestBody SaveCompetitionDto instance) {
        return ResponseEntity.ok(service.update(id, instance));
    }

    @PatchMapping(path = "/{id}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ReadCompetitionDto> patch(@PathVariable UUID id,
                                                    @RequestBody SaveCompetitionDto instance) {
        return ResponseEntity.ok(service.patch(id, instance));
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }

}
