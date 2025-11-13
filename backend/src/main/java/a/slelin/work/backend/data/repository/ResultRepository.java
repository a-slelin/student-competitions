package a.slelin.work.backend.data.repository;

import a.slelin.work.backend.data.entity.Result;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ResultRepository extends JpaRepository<Result, String>,
        PagingAndSortingRepository<Result, String>, JpaSpecificationExecutor<Result> {

    Page<Result> findAllBySortOrder(Integer sortOrder, Pageable pageable);

    Page<Result> findAllByNameContaining(String name, Pageable pageable);

    Page<Result> findAllBySortOrderAndNameContaining(Integer sortOrder, String name, Pageable pageable);

    boolean existsByName(String name);

    boolean existsByNameAndCodeNot(String name, String code);
}
