package mx.edu.utez.viajabara.basecatalog.typeBus.model;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TypeBusRepository extends JpaRepository<TypeBus,Long> {

    List<TypeBus> findAllByStatusIsTrue();

    Optional<TypeBus> findById(Long id);
    Optional<TypeBus> findByDescription(String description);
}
