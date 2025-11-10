package a.slelin.work.backend.data.repository;

import a.slelin.work.backend.data.entity.Result;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ResultRepository extends JpaRepository<Result, String>,
        PagingAndSortingRepository<Result, String>, JpaSpecificationExecutor<Result> {
}
