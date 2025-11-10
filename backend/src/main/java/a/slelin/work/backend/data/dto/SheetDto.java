package a.slelin.work.backend.data.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import org.springframework.data.domain.Page;

import java.util.List;

@Builder
public record SheetDto<T>(@NotNull @Valid List<T> content,
                          @NotNull @Valid PageDto<T> page) implements ReadDto {

    public static <T> SheetDto<T> of(Page<T> page) {
        return new SheetDto<>(page.getContent(), PageDto.of(page));
    }
}
