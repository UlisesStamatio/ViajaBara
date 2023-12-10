package mx.edu.utez.viajabara.basecatalog.qualifications.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface QualificationsRepository extends JpaRepository<Qualifications,Long> {
    @Query(value = "SELECT q.* from qualifications q inner join seatings_sales ss on q.seating_sales_id = ss.id where ss.open_trips_id = ?1",nativeQuery = true)
    List<Qualifications> searchAllByOpenTrip(Long openTripId);

    @Query(value = "SELECT AVG(q.score) FROM qualifications q inner join seatings_sales ss on q.seating_sales_id = ss.id inner join open_trips ot on ss.open_trips_id = ot.id inner join trips t on ot.trip_id = t.id where driver_id = ?1",nativeQuery = true)
    long generalQualificationByDriver(long driverId);
}
