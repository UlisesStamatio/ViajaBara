package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface OpenTripsRepository extends JpaRepository<OpenTrips,Long> {
    @Query(value = "SELECT * from open_trips where status=?1",nativeQuery = true)
    List<OpenTrips> searchAllByStatusActive(int status);
    
    @Query("SELECT new mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsDto(ot.id, ot.trip, DATE_FORMAT(ot.startDate, '%Y-%m-%d'), ot.status, ot.enableSeats) FROM OpenTrips ot WHERE ot.trip.id = :tripId AND ot.startDate = STR_TO_DATE(:startDate, '%Y-%m-%d') AND ot.enableSeats > 0")
    OpenTripsDto findByTripIdAndDate(@Param("tripId") Long tripId, @Param("startDate") String startDate);

    @Query(value = "SELECT op.* FROM open_trips op inner join trips t on op.trip_id = t.id where (op.status = 1 OR op.status = 2) AND DATE(op.start_date) = CURDATE() AND t.driver_id = ?1",nativeQuery = true)
    List<OpenTrips> searchAllTripsToday(long driver_id);

    @Query(value = "SELECT op.* FROM open_trips op inner join trips t on op.trip_id = t.id where op.status = 3 AND t.driver_id = ?1",nativeQuery = true)
    List<OpenTrips> searchAllTripsHistory(long driver_id);


    @Query(value = "SELECT * FROM open_trips WHERE trip_id = :tripId AND status is true AND start_date <= CURDATE()", nativeQuery = true)
    List<OpenTrips> findOpenTripsByTripIdNotInProgress(@Param("tripId") Long tripId);


    @Query(value = "SELECT COUNT(o.id) from open_trips o inner join trips join trips t on o.trip_id = t.id WHERE t.driver_id = ?1",nativeQuery = true)
    long countTripsByDriver(long driverId);
}
