package mx.edu.utez.viajabara.basecatalog.duty.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface DutyRepository extends JpaRepository<Duty,Long> {

    List<Duty> findAllByStatusIsTrue();

    @Query(value = "SELECT * " + "FROM duties " + "WHERE name LIKE ?1 " + "AND id != ?2 " + "LIMIT 1", nativeQuery = true)
    Optional<Duty> searchByNameAndId(String name, Long id);
}
