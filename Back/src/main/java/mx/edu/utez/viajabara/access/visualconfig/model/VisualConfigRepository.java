package mx.edu.utez.viajabara.access.visualconfig.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VisualConfigRepository extends JpaRepository<VisualConfig, Long> {
    VisualConfig findFirstByStatus(boolean status);
}
