package a.slelin.work.backend.data.repository;

import a.slelin.work.backend.data.entity.Competition;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface CompetitionRepository extends JpaRepository<Competition, UUID>,
        PagingAndSortingRepository<Competition, UUID>, JpaSpecificationExecutor<Competition> {
}
