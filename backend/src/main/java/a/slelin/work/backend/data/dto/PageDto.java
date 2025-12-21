package a.slelin.work.backend.data.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import org.springframework.data.domain.Page;

import java.util.List;

@Builder
public record PageDto(@NotNull @Min(0) Integer number,
                      @NotNull @Min(1) Integer size,
                      @NotNull @Valid List<SortDto> sorts,
                      @NotNull @Min(0) Long totalElements,
                      @NotNull @Min(0) Integer totalPages,
                      boolean first,
                      boolean last,
                      boolean empty) {

    public static PageDto of(Page<?> page) {
        if (page == null) {
            throw new IllegalArgumentException("Page should be not null.");
        }

        List<SortDto> sorts = page.getSort().stream()
                .map(order -> new SortDto(order.getProperty(), order.getDirection().toString()))
                .toList();

        return PageDto.builder()
                .number(page.getNumber())
                .size(page.getSize())
                .sorts(sorts)
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .first(page.isFirst())
                .last(page.isLast())
                .empty(page.isEmpty())
                .build();
    }
}
