package mx.edu.utez.viajabara.basecatalog.trip.model;

import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface TripRepository extends JpaRepository<Trip,Long> {
    List<Trip> findAllByStatusIsTrue();

    @Query("SELECT DISTINCT ts " +
            "FROM Trip t " +
            "INNER JOIN t.ways w " +
            "INNER JOIN TripSchedule ts ON ts.trip = t " +
            "WHERE t.status = true " +
            "AND w.status = true " +
            "AND ts.status = true " +
            "AND DATE(ts.startDate) = :startDate ")
    List<TripSchedule> findTripsAvailableInDay(@Param("startDate") Date startDate);



}
