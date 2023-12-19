package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripSchedule;
import mx.edu.utez.viajabara.utils.validator.CheckDateFormat;
import org.springframework.format.annotation.DateTimeFormat;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class OpenTripsDto {
    @NotNull(groups = {Modify.class,ChangeStatus.class})
    private Long id;
    @NotNull(groups = {Register.class,Modify.class})
    private Long idTrip;
    @NotNull(groups = {Register.class,Modify.class})
    private List<TripSchedule> schedules;
    @PositiveOrZero(groups = {ChangeStatus.class})
    private int status;
    private int enableSeats;

    private List<SeatingSales> seatingSales;
    @NotNull(groups = {Register.class,Modify.class})
    private String seatsDistribution;

    private Date createdAt;


    public OpenTripsDto() {
    }

    public OpenTripsDto(Long id, List<TripSchedule> schedules, int status, int enableSeats) {
        this.id = id;
        this.schedules = schedules;
        this.status = status;
        this.enableSeats = enableSeats;
    }

    public OpenTripsDto(Long id, List<TripSchedule> schedules, int status, int enableSeats, Date createdAt) {
        this.id = id;
        this.schedules = schedules;
        this.status = status;
        this.enableSeats = enableSeats;
        this.createdAt = createdAt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


/*    public Date getStartDate() {
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(String.valueOf(startDate));
        } catch (Exception e) {
            return null;
        }
    }*/


    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getEnableSeats() {
        return enableSeats;
    }

    public void setEnableSeats(int enableSeats) {
        this.enableSeats = enableSeats;
    }

    public List<SeatingSales> getSeatingSales() {
        return seatingSales;
    }

    public void setSeatingSales(List<SeatingSales> seatingSales) {
        this.seatingSales = seatingSales;
    }

    public String getSeatsDistribution() {
        return seatsDistribution;
    }

    public void setSeatsDistribution(String seatsDistribution) {
        this.seatsDistribution = seatsDistribution;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }


    public List<TripSchedule> getSchedule() {
        return schedules;
    }

    public void setSchedule(List<TripSchedule> schedules) {
        this.schedules = schedules;
    }

    public Long getIdTrip() {
        return idTrip;
    }

    public void setIdTrip(Long idTrip) {
        this.idTrip = idTrip;
    }

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}

    @Override
    public String toString() {
        return "OpenTripsDto{" +
                "id=" + id +
                ", tripSchedules=" + schedules +
                ", status=" + status +
                ", enableSeats=" + enableSeats +
                ", createdAt=" + createdAt +
                '}';
    }
}