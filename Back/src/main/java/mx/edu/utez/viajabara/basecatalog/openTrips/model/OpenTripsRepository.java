package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OpenTripsRepository extends JpaRepository<OpenTrips,Long> {
    @Query(value = "SELECT * from open_trips where status=?1",nativeQuery = true)
    List<OpenTrips> searchAllByStatusActive(int status);


    @Query(value = "SELECT op.* FROM open_trips op inner join trips t on op.trip_id = t.id where (op.status = 1 OR op.status = 2) AND DATE(op.start_date) = CURDATE() AND t.driver_id = ?1",nativeQuery = true)
    List<OpenTrips> searchAllTripsToday(long driver_id);

}
