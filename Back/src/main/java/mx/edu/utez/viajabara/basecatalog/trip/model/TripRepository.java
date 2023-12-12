package mx.edu.utez.viajabara.basecatalog.trip.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface TripRepository extends JpaRepository<Trip,Long> {
    List<Trip> findAllByStatusIsTrue();

    @Query("SELECT t " +
            "FROM Trip t " +
            "INNER JOIN t.ways w " +
            "WHERE t.status = true " +
            "AND w.status = true " +
            "AND JSON_SEARCH(t.workDays, 'one', :workDay) IS NOT NULL")
    List<Trip> findTripsAvailableInDay(@Param("workDay") String workDay);


}
