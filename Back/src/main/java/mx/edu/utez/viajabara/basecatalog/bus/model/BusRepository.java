package mx.edu.utez.viajabara.basecatalog.bus.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface BusRepository extends JpaRepository<Bus,Long> {
    List<Bus> findAllByStatusIsTrue();

    @Query(value = "SELECT * " + "FROM  buses " + "WHERE plaque LIKE ?1 " + "AND id != ?2 " + "LIMIT 1", nativeQuery = true)
    Optional<Bus> searchByPlaqueAndId(String name, Long id);

    @Query(value = "SELECT * " + "FROM  buses " + "WHERE serial LIKE ?1 " + "AND id != ?2 " + "LIMIT 1", nativeQuery = true)
    Optional<Bus> searchBySerialAndId(String name, Long id);
}
