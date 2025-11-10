package a.slelin.work.backend.data.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import org.springframework.data.domain.Page;

import java.util.List;

@Builder
public record PageDto<T>(@NotNull Integer number,
                         @NotNull Integer size,
                         @NotNull List<SortDto> sorts,
                         @NotNull Long totalElements,
                         @NotNull Integer totalPages,
                         @NotNull Boolean first,
                         @NotNull Boolean last,
                         @NotNull Boolean empty) {

    public static <T> PageDto<T> of(Page<T> page) {
        return new PageDto<>(
                page.getNumber(),
                page.getSize(),
                page.getSort().stream()
                        .map(order -> new SortDto(order.getProperty(), order.getDirection().toString()))
                        .toList(),
                page.getTotalElements(),
                page.getTotalPages(),
                page.isFirst(),
                page.isLast(),
                page.isEmpty()
        );
    }
}
