package a.slelin.work.backend.controller;

import a.slelin.work.backend.data.dto.ReadParticipationDto;
import a.slelin.work.backend.data.dto.SaveParticipationDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.filter.FilterChain;
import a.slelin.work.backend.service.ParticipationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.UUID;

@RestController
@RequestMapping("/${api.api-prefix}/${api.participation-prefix}")
public class ParticipationController {

    @Autowired
    private ControllerConfig config;

    @Autowired
    private ParticipationService service;

    @GetMapping(produces = "application/json")
    public ResponseEntity<SheetDto<ReadParticipationDto>> get(@PageableDefault Pageable pageable) {
        return ResponseEntity.ok(service.get(pageable));
    }

    @GetMapping(path = "/{id}", produces = "application/json")
    public ResponseEntity<ReadParticipationDto> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.getById(id));
    }

    @PostMapping(path = "/${api.search-prefix}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<SheetDto<ReadParticipationDto>> search(@RequestBody FilterChain filter,
                                                                 @PageableDefault Pageable pageable) {
        return ResponseEntity.ok(service.getByFilter(filter, pageable));
    }

    @PostMapping(consumes = "application/json")
    public ResponseEntity<Void> create(@RequestBody SaveParticipationDto instance) {
        UUID id = service.save(instance);

        URI location = URI.create(config.getParticipationUri() + "/" + id.toString());

        return ResponseEntity.created(location).build();
    }

    @PutMapping(path = "/{id}", consumes = "application/json", produces = "applicatoin/json")
    public ResponseEntity<ReadParticipationDto> update(@PathVariable UUID id,
                                                       @RequestBody SaveParticipationDto instance) {
        return ResponseEntity.ok(service.update(id, instance));
    }

    @PatchMapping(path = "/{id}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ReadParticipationDto> patch(@PathVariable UUID id,
                                                      @RequestBody SaveParticipationDto instance) {
        return ResponseEntity.ok(service.patch(id, instance));
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
