package mx.edu.utez.viajabara.access.user.model;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @Query(value = "SELECT * " +
            "FROM users " +
            "WHERE CAST(roles AS TEXT) LIKE ?1 ", nativeQuery = true)
    List<User> searchAllByRole(String role);

    @Query(value = "SELECT * " +
            "FROM users " +
            "WHERE CAST(roles AS TEXT) LIKE ?1 AND id = ?2", nativeQuery = true)
    Optional<User> searchUserWithRole(String role, Long id);

    Optional<User> findFirstByEmail(String mail);

    List<User> findAllByStatus(boolean status);

    @Query(value = "SELECT *, p.name as name, p.surname as surname FROM users u inner join people p on u.person_id = p.id and UPPER(u.email) LIKE UPPER(email) AND JSON_EXTRACT(u.roles, '$[*].id') LIKE '%2%'", nativeQuery = true)
    List<User> searchAllDriversByPaginationEmail(String value, String email, Pageable offset);

    @Query(value = "SELECT *, p.name as name, p.surname as surname FROM users u inner join people p on u.person_id = p.id and UPPER(CONCAT(p.name,' ',p.surname)) LIKE UPPER(?1) AND JSON_EXTRACT(u.roles, '$[*].id') LIKE '%2%'", nativeQuery = true)
    List<User> searchAllDriversByPaginationName(String value, String email, Pageable offset);

    @Query(value = "SELECT *, p.name as name, p.surname as surname FROM users u inner join people p on u.person_id = p.id and UPPER(u.email) LIKE UPPER(email) AND JSON_EXTRACT(u.roles, '$[*].id') LIKE '%3%'", nativeQuery = true)
    List<User> searchAllConsumersByPaginationEmail(String value, String email, Pageable offset);

    @Query(value = "SELECT *, p.name as name, p.surname as surname FROM users u inner join people p on u.person_id = p.id and UPPER(CONCAT(p.name,' ',p.surname)) LIKE UPPER(?1) AND JSON_EXTRACT(u.roles, '$[*].id') LIKE '%3%'", nativeQuery = true)
    List<User> searchAllConsumersByPaginationName(String value, String email, Pageable offset);

    @Query(value = "SELECT *, p.name as name, p.surname as surname FROM users u inner join people p on u.person_id = p.id AND JSON_EXTRACT(u.roles, '$[*].id') LIKE '%2%'",nativeQuery = true)
    List<User> searchAllDrivers();

    @Query(value = "SELECT *, p.name as name, p.surname as surname FROM users u inner join people p on u.person_id = p.id AND JSON_EXTRACT(u.roles, '$[*].id') LIKE '%3%'",nativeQuery = true)
    List<User> searchAllConsumers();

    @Query(value = "SELECT *, p.name as name, p.surname as surname FROM users u inner join people p on u.person_id = p.id AND JSON_EXTRACT(u.roles, '$[*].id') LIKE '%2%' and u.status is true",nativeQuery = true)
    List<User> searchAllDriversEnabled();
}
