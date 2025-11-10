package a.slelin.work.backend.filter;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.domain.Specification;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class FilterUtil {

    public static <T> Specification<T> toSpecification(FilterChain filterChain) {
        return null;
    }
}
