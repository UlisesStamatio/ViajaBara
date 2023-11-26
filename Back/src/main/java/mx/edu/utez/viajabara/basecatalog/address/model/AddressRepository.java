package mx.edu.utez.viajabara.basecatalog.address.model;

import mx.edu.utez.viajabara.basecatalog.paymentMethod.model.PaymentMethod;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface AddressRepository extends JpaRepository<Address, Long> {
    Optional<Address> findByLatitudeAndLongitude(String latitude, String longitude);

}
