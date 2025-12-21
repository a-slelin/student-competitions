package a.slelin.work.backend.controller;

import a.slelin.work.backend.data.dto.*;
import a.slelin.work.backend.filter.FilterChain;
import a.slelin.work.backend.service.LevelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;

@RestController
@RequestMapping("/${api.api-prefix}/${api.level-prefix}")
public class LevelController {

    @Autowired
    private ControllerConfig config;

    @Autowired
    private LevelService service;

    @GetMapping(produces = "application/json")
    public ResponseEntity<SheetDto<ReadLevelDto>> get(@RequestParam(required = false) String name,
                                                      @RequestParam(required = false) Integer order,
                                                      @PageableDefault Pageable pageable) {
        return ResponseEntity.ok(service.get(name, order, pageable));
    }

    @GetMapping(path = "/{id}", produces = "application/json")
    public ResponseEntity<ReadLevelDto> getById(@PathVariable String id) {
        return ResponseEntity.ok(service.getById(id));
    }

    @PostMapping(path = "/${api.search-prefix}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<SheetDto<ReadLevelDto>> search(@RequestBody FilterChain filter,
                                                         @PageableDefault Pageable pageable) {
        return ResponseEntity.ok(service.getByFilter(filter, pageable));
    }

    @PostMapping(consumes = "application/json")
    public ResponseEntity<Void> create(@RequestBody SaveLevelDto instance) {
        String id = service.save(instance);

        URI location = URI.create(config.getLevelUri() + "/" + id);

        return ResponseEntity.created(location).build();
    }

    @PutMapping(path = "/{id}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ReadLevelDto> update(@PathVariable String id,
                                               @RequestBody SaveLevelDto instance) {
        return ResponseEntity.ok(service.update(id, instance));
    }

    @PatchMapping(path = "/{id}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ReadLevelDto> patch(@PathVariable String id,
                                              @RequestBody SaveLevelDto instance) {
        return ResponseEntity.ok(service.patch(id, instance));
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable String id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
