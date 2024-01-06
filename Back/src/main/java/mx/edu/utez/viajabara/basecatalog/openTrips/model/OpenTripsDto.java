package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;
import java.util.Date;
import java.util.List;

public class OpenTripsDto {
    @NotNull(groups = {Modify.class,ChangeStatus.class})
    private Long id;
    @NotNull(groups = {Register.class,Modify.class})
    private Long idTrip;

    @PositiveOrZero(groups = {Register.class,Modify.class})
    private Integer numberWeeks;
    @PositiveOrZero(groups = {ChangeStatus.class})
    private int status;
    private int enableSeats;
    private List<SeatingSales> seatingSales;

    private String seatsDistribution;

    private Date createdAt;


    public OpenTripsDto() {
    }

    public OpenTripsDto(Long id, int status, int enableSeats) {
        this.id = id;
        this.status = status;
        this.enableSeats = enableSeats;
    }

    public OpenTripsDto(Long id, int status, int enableSeats, Date createdAt) {
        this.id = id;
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

    public Long getIdTrip() {
        return idTrip;
    }

    public void setIdTrip(Long idTrip) {
        this.idTrip = idTrip;
    }

    public Integer getNumberWeeks() {
        return numberWeeks;
    }

    public void setNumberWeeks(Integer numberWeeks) {
        this.numberWeeks = numberWeeks;
    }

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}

    @Override
    public String toString() {
        return "OpenTripsDto{" +
                "id=" + id +
                ", status=" + status +
                ", enableSeats=" + enableSeats +
                ", createdAt=" + createdAt +
                '}';
    }
}