package a.slelin.work.backend.filter;

import a.slelin.work.backend.exception.*;
import jakarta.persistence.criteria.*;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class FilterUtil {

    public static <T> Specification<T> toSpecification(FilterChain filterChain) {
        return (root, _, criteriaBuilder) -> {
            if (filterChain == null || filterChain.isEmpty()) {
                return criteriaBuilder.conjunction();
            }

            Predicate[] predicates = filterChain.getFilters().stream()
                    .filter(Objects::nonNull)
                    .map(filter -> toPredicate(filter, root, criteriaBuilder))
                    .toArray(Predicate[]::new);

            return criteriaBuilder.and(predicates);
        };
    }

    public static <T> Predicate toPredicate(Filter filter, Root<T> root, CriteriaBuilder cb) {
        String field = filter.field();
        Operation operation = filter.operation();
        Object value = filter.value();
        Object value2 = filter.value2();

        Path<T> path = getNestedPath(root, field);

        try {
            return switch (operation) {
                case EQ -> cb.equal(path, value);
                case NEQ -> cb.notEqual(path, value);

                case IS_NULL -> cb.isNull(path);
                case IS_NOT_NULL -> cb.isNotNull(path);

                case GT, GE, LT, LE -> {
                    Expression<Number> expression = pathToType(path, Number.class);

                    Number number = valueToType(value, Number.class);

                    yield switch (operation) {
                        case GT -> cb.gt(expression, number);
                        case GE -> cb.ge(expression, number);
                        case LT -> cb.lt(expression, number);
                        case LE -> cb.le(expression, number);
                        default -> throw new IllegalArgumentException("Unexpected value");
                    };
                }

                case LIKE, NOT_LIKE, STARTS_WITH, NOT_STARTS_WITH, ENDS_WITH, NOT_ENDS_WITH -> {
                    Expression<String> expression = pathToType(path, String.class);

                    String str = valueToType(value, String.class);

                    yield switch (operation) {
                        case LIKE -> cb.like(cb.lower(expression), "%" + str.toLowerCase() + "%");
                        case NOT_LIKE -> cb.notLike(cb.lower(expression), "%" + str.toLowerCase() + "%");
                        case STARTS_WITH -> cb.like(cb.lower(expression), str.toLowerCase() + "%");
                        case NOT_STARTS_WITH -> cb.notLike(cb.lower(expression), str.toLowerCase() + "%");
                        case ENDS_WITH -> cb.like(cb.lower(expression), "%" + str.toLowerCase());
                        case NOT_ENDS_WITH -> cb.notLike(cb.lower(expression), "%" + str.toLowerCase());
                        default -> throw new IllegalArgumentException("Unexpected value");
                    };
                }

                case IS_EMPTY, IS_NOT_EMPTY -> {
                    Expression<Collection> expression = pathToType(path, Collection.class);

                    yield switch (operation) {
                        case IS_EMPTY -> cb.isEmpty(expression);
                        case IS_NOT_EMPTY -> cb.isNotEmpty(expression);
                        default -> throw new IllegalArgumentException("Unexpected value");
                    };
                }

                case IS_TRUE, IS_FALSE -> {
                    Expression<Boolean> expression = pathToType(path, Boolean.class);

                    yield switch (operation) {
                        case IS_TRUE -> cb.isTrue(expression);
                        case IS_FALSE -> cb.isFalse(expression);
                        default -> throw new IllegalArgumentException("Unexpected value");
                    };
                }

                case IN, NOT_IN -> {
                    List<?> list = valueToType(value, List.class);

                    yield switch (operation) {
                        case IN -> path.in(list);
                        case NOT_IN -> cb.not(path.in(list));
                        default -> throw new IllegalArgumentException("Unexpected value");
                    };
                }

                case BETWEEN, NOT_BETWEEN -> {
                    Expression<Comparable> expression = pathToType(path, Comparable.class);

                    Comparable from = valueToType(value, Comparable.class);
                    Comparable to = valueToType(value2, Comparable.class);

                    yield switch (operation) {
                        case BETWEEN -> cb.between(expression, from, to);
                        case NOT_BETWEEN -> cb.not(cb.between(expression, from, to));
                        default -> throw new IllegalArgumentException("Unexpected value");
                    };
                }

                case BEFORE, AFTER -> {
                    Expression<LocalDateTime> expression = pathToType(path, LocalDateTime.class);

                    LocalDateTime date = valueToType(value, LocalDateTime.class);

                    yield switch (operation) {
                        case BEFORE -> cb.lessThan(expression, date);
                        case AFTER -> cb.greaterThan(expression, date);
                        default -> throw new IllegalArgumentException("Unexpected value");
                    };
                }

                default -> throw new FilterParseOperationException(null, "Unknown filter operation.");
            };
        } catch (FilterException e) {
            throw e;
        } catch (Exception e) {
            throw new FilterException();
        }
    }

    public static <T> Path<T> getNestedPath(Root<T> root, String field) {
        if (field == null) {
            throw new FilterPathException(null, "Filter field should be not null.");
        }

        try {
            String[] parts = field.split("\\.");
            Path<T> currentPath = root;

            for (String part : parts) {
                if (part == null || part.isBlank()) {
                    throw new FilterPathException(field, "Invalid field path format : empty part.");
                }

                try {
                    currentPath = currentPath.get(part);
                } catch (Exception e) {
                    throw new FilterPathException(field, "Invalid part path format : " + part);
                }
            }

            return currentPath;

        } catch (FilterException e) {
            throw e;
        } catch (Exception e) {
            throw new FilterException();
        }
    }

    public static <T> Expression<T> pathToType(Path<?> path, Class<T> type) {
        if (path == null) {
            throw new FilterPathException(null, "Filter path should be not null.");
        }

        try {
            return path.as(type);
        } catch (Exception e) {
            String field = path.toString();

            Class<?> realType = path.getJavaType();
            if (realType == null) {
                realType = path.getModel().getBindableJavaType();
            }

            throw new FilterPathTypeException(field, realType, type);
        }
    }

    public static <T> T valueToType(Object value, Class<T> type) {
        if (value == null) {
            throw new FilterValueException(null, "Value should be not null");
        }

        try {
            return type.cast(value);
        } catch (Exception e) {
            throw new FilterValueTypeException(value, type);
        }
    }
}
