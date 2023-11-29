package mx.edu.utez.viajabara.basecatalog.trip.model;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TripRepository extends JpaRepository<Trip,Long> {
    List<Trip> findAllByStatusIsTrue();

    Optional<Trip> findByRouteIdAndStatusTrue(Long id);
}
