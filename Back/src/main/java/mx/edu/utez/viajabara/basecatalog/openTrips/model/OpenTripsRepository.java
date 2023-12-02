package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OpenTripsRepository extends JpaRepository<OpenTrips,Long> {
    @Query(value = "SELECT * from open_trips where status=?1",nativeQuery = true)
    List<OpenTrips> searchAllByStatusActive(int status);
    @Query("SELECT new mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsDto(ot.id, ot.trip, DATE_FORMAT(ot.startDate, '%Y-%m-%d'), ot.status, ot.enableSeats) FROM OpenTrips ot WHERE ot.trip.id = :tripId AND ot.startDate = STR_TO_DATE(:startDate, '%Y-%m-%d')")
    OpenTripsDto findByTripIdAndDate(@Param("tripId") Long tripId, @Param("startDate") String startDate);


}
