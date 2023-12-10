package mx.edu.utez.viajabara.basecatalog.way.model;

import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface WayRepository  extends JpaRepository<Way, Long> {

    Optional<Way> findFirstByTripAndRoute(Trip trip, Route route);

    List<Way> findByTripId(Long id);


    @Query(value = "SELECT w.* FROM trips t inner join ways w ON t.id = w.trip_id WHERE t.status is true AND w.route_id = :routeId", nativeQuery = true)
    Optional<Way> findByRouteIdAndTripStatusIsTrue(@Param("routeId") Long routeId);
}
