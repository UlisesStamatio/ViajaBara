package mx.edu.utez.viajabara.basecatalog.tripSchedule.model;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface TripScheduleRepository extends JpaRepository<TripSchedule, Long> {

    Optional<TripSchedule> findByStartDateAndEndDateAndTripId(Date startDate, Date endDate, Long id);


    List<TripSchedule> findAllByTripId(Long id);

}
