package mx.edu.utez.viajabara.basecatalog.seatingSales.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SeatingSalesRepository extends JpaRepository<SeatingSales,Long> {
    List<SeatingSales> findAllByClient(User user);
    List<SeatingSales> findAllByOpenTrips(OpenTrips openTrips);
}
