package mx.edu.utez.viajabara.basecatalog.paymentMethod.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface PaymentMethodRepository extends JpaRepository<PaymentMethod, Long> {
    List<PaymentMethod> findAllByStatusIsTrue();

    @Query(value = "SELECT * " + "FROM  payment_methods " + "WHERE name LIKE ?1 " + "AND id != ?2 " + "LIMIT 1", nativeQuery = true)
    Optional<PaymentMethod> searchByNameAndId(String name, Long id);
    Optional<PaymentMethod> findFirstByName(String name);

    List<PaymentMethod> findAllByOrderByStatusDesc();
}
