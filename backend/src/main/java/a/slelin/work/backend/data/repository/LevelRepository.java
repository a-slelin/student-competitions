package a.slelin.work.backend.data.repository;

import a.slelin.work.backend.data.entity.Level;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LevelRepository extends JpaRepository<Level, String>,
        PagingAndSortingRepository<Level, String>, JpaSpecificationExecutor<Level> {

    Page<Level> findAllByNameContaining(String name, Pageable pageable);

    Page<Level> findAllBySortOrder(Integer sortOrder, Pageable pageable);

    Page<Level> findAllBySortOrderAndNameContaining(Integer sortOrder, String name, Pageable pageable);

    boolean existsByName(String name);

    boolean existsByNameAndCodeNot(String name, String code);
}
