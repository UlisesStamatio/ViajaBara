package mx.edu.utez.viajabara.basecatalog.stopover.model;

import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface StopOverRepository extends JpaRepository<StopOver, Long> {
    Optional<StopOver> findFirstByAddressAndRoute(Address address,  Route route);
    List<StopOver> findAllByRoute(Route route);
}
