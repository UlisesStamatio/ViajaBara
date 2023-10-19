package mx.edu.utez.viajabara.basecatalog.state.model;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StateRepository extends JpaRepository<State, Long> {
    @Query(value = "SELECT * " + "FROM states " + "WHERE name LIKE ?1 " + "AND id != ?2 " + "LIMIT 1", nativeQuery = true)
    Optional<State> searchByNameAndId(String name, Long id);

    @Query(value = "SELECT COUNT(id) FROM states ", nativeQuery = true)
    long searchCount();

    List<State> findAllByStatusOrderByName(boolean status);

    @Query(value = "SELECT s FROM State s WHERE UPPER(s.name) LIKE UPPER(?1) ")
    List<State> searchAllByPagination(String value, Pageable offset);

    Optional<State> findFirstByName(String name);
}
