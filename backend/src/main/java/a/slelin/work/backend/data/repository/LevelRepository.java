package a.slelin.work.backend.data.repository;

import a.slelin.work.backend.data.entity.Level;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LevelRepository extends JpaRepository<Level, String>,
        PagingAndSortingRepository<Level, String>, JpaSpecificationExecutor<Level> {
}
