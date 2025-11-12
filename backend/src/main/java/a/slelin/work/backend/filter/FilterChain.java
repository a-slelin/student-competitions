package a.slelin.work.backend.filter;

import jakarta.validation.constraints.NotNull;

import java.util.*;

public class FilterChain {

    @NotNull
    private final List<Filter> filters;

    private FilterChain(@NotNull List<Filter> filters) {
        this.filters = new ArrayList<>();
        Collections.copy(this.filters, filters);
    }

    public List<Filter> getFilters() {
        return Collections.unmodifiableList(filters);
    }

    public boolean isEmpty() {
        return filters.isEmpty();
    }

    public void clear() {
        filters.clear();
    }

    public int size() {
        return filters.size();
    }

    public static FilterChain empty() {
        return new FilterChain(new ArrayList<>());
    }

    public static FilterChain of(@NotNull Filter... filters) {
        return new FilterChain(Arrays.stream(filters)
                .filter(Objects::nonNull)
                .toList());
    }

    public static FilterChain of(@NotNull List<Filter> filters) {
        return new FilterChain(new ArrayList<>(filters).stream()
                .filter(Objects::nonNull)
                .toList());
    }

    public FilterChain copy() {
        return new FilterChain(new ArrayList<>(filters));
    }

    public FilterChain add(@NotNull Filter filter) {
        if (!filters.contains(filter)) {
            filters.add(filter);
        }

        return this;
    }

    public FilterChain remove(@NotNull Filter filter) {
        filters.remove(filter);
        return this;
    }
}
