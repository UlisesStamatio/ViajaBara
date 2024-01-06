package mx.edu.utez.viajabara.basecatalog.tripSchedule.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface TripScheduleRepository extends JpaRepository<TripSchedule, Long> {

    Optional<TripSchedule> findByStartDateAndEndDateAndTripId(Date startDate, Date  endDate, Long id);


    List<TripSchedule> findAllByTripIdAndStatusIsTrue(Long id);


    @Query(value = "SELECT ts.* FROM trip_schedule ts INNER JOIN trips t ON ts.trip_id = t.id WHERE t.driver_id = :id AND ts.status is true", nativeQuery = true)
    List<TripSchedule> findAllByDriverIdAndStatusIsTrue(@Param("id") Long id);

}
