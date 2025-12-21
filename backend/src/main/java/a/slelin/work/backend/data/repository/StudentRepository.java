package a.slelin.work.backend.data.repository;

import a.slelin.work.backend.data.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface StudentRepository extends JpaRepository<Student, UUID>,
        PagingAndSortingRepository<Student, UUID>, JpaSpecificationExecutor<Student> {

    boolean existsByCardNumber(Long cardNumber);

    boolean existsByCardNumberAndIdNot(Long cardNumber, UUID id);
}
