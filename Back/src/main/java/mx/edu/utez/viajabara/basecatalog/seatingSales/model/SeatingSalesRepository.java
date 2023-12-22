package mx.edu.utez.viajabara.basecatalog.seatingSales.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SeatingSalesRepository extends JpaRepository<SeatingSales,Long> {
    List<SeatingSales> findAllByClient(User user);


    @Query(value = "SELECT ss.* FROM seatings_sales ss JOIN stopovers so ON ss.id_end_address = so.id_address WHERE so.id = ?1 and ss.open_trips_id = ?2",nativeQuery = true)
    List<SeatingSales> searchAllOutByStopOverAnAndOpenTrips(long idStopOver,long idOpenTrip);

    @Query(value = "SELECT ss.* FROM seatings_sales ss JOIN stopovers so ON ss.id_start_address = so.id_address WHERE so.id = ?1 and ss.open_trips_id = ?2",nativeQuery = true)
    List<SeatingSales> searchAllOnByStopOverAnAndOpenTrips(long idStopOver,long idOpenTrip);


    @Query(value = "SELECT COUNT(DISTINCT(s.open_trips_id)) FROM seatings_sales s where s.client_id = ?1 and s.checked is true",nativeQuery = true)
    long countTripsByClient(long idClient);

    /*@Query("SELECT ss.seatsSelected " +
            "FROM SeatingSales ss " +
            "JOIN ss.openTrips ot " +
            "WHERE ot.trip.id = :tripId " +
            "AND ot.startDate = STR_TO_DATE(:startDate, '%Y-%m-%d')  " +
            "AND (ss.startAddress.id <= :endAddressId AND ss.startAddress.id >= :startAddressId) " +
            "OR (ss.endAddress.id <= :endAddressId AND ss.endAddress.id >= :startAddressId)")
    List<String> findSeatsSelectedByCriteria(
            @Param("tripId") Long tripId,
            @Param("startDate") String startDate,
            @Param("startAddressId") Long startAddressId,
            @Param("endAddressId") Long endAddressId
    );*/
}
