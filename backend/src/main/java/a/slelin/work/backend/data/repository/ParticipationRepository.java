package a.slelin.work.backend.data.repository;

import a.slelin.work.backend.data.entity.Participation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ParticipationRepository extends JpaRepository<Participation, UUID>,
        PagingAndSortingRepository<Participation, UUID>, JpaSpecificationExecutor<Participation> {
}
