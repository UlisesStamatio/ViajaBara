package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OpenTripsRepository extends JpaRepository<OpenTrips,Long> {
    @Query(value = "SELECT * from open_trips where status=?1",nativeQuery = true)
    List<OpenTrips> searchAllByStatusActive(int status);
}
