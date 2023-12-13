package mx.edu.utez.viajabara.basecatalog.address.model;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AddressRepository extends JpaRepository<Address, Long> {
    Optional<Address> findByLatitudeAndLongitude(String latitude, String longitude);

}
