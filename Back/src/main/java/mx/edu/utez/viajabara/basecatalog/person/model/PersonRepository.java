package mx.edu.utez.viajabara.basecatalog.person.model;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PersonRepository extends JpaRepository<Person, Long> {
    List<Person> findAllByStatus(boolean state);

    Optional<Person> findByName(String name);

}
