package a.slelin.work.backend.controller;

import a.slelin.work.backend.data.dto.ReadStudentDto;
import a.slelin.work.backend.data.dto.SaveStudentDto;
import a.slelin.work.backend.data.dto.SheetDto;
import a.slelin.work.backend.filter.FilterChain;
import a.slelin.work.backend.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.UUID;

@RestController
@RequestMapping(path = "/${api.api-prefix}/${api.student-prefix}")
public class StudentController {

    @Autowired
    public ControllerConfig config;

    @Autowired
    private StudentService service;

    @GetMapping(produces = "application/json")
    public ResponseEntity<SheetDto<ReadStudentDto>> get(@PageableDefault Pageable pageable) {
        return ResponseEntity.ok(service.get(pageable));
    }

    @GetMapping(path = "/{id}", produces = "application/json")
    public ResponseEntity<ReadStudentDto> getById(@PathVariable UUID id) {
        return ResponseEntity.ok(service.getById(id));
    }

    @PostMapping(path = "/${api.search-prefix}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<SheetDto<ReadStudentDto>> get(@RequestBody FilterChain filter,
                                                        @PageableDefault Pageable pageable) {
        return ResponseEntity.ok(service.getByFilter(filter, pageable));
    }

    @PostMapping(consumes = "application/json")
    public ResponseEntity<Void> create(@RequestBody SaveStudentDto instance) {
        UUID id = service.save(instance);

        URI location = URI.create(config.getStudentUri() + "/" + id.toString());

        return ResponseEntity.created(location).build();
    }

    @PutMapping(path = "/{id}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ReadStudentDto> update(@PathVariable UUID id,
                                                 @RequestBody SaveStudentDto instance) {
        return ResponseEntity.ok(service.update(id, instance));
    }

    @PatchMapping(path = "/{id}", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ReadStudentDto> patch(@PathVariable UUID id,
                                                @RequestBody SaveStudentDto instance) {
        return ResponseEntity.ok(service.patch(id, instance));
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        service.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
