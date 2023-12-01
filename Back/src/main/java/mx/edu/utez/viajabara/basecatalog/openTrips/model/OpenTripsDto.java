package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.utils.validator.CheckDateFormat;
import org.hibernate.annotations.Type;
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
    private Trip trip;
    @CheckDateFormat(pattern = "yyyy/MM/dd",groups = {Register.class,Modify.class})
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private String startDate;

    @PositiveOrZero(groups = {ChangeStatus.class})
    private int status;
    private int enableSeats;

    private List<SeatingSales> seatingSales;
    @NotNull(groups = {Register.class,Modify.class})
    private String seatsDistribution;

    public OpenTripsDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Trip getTrip() {
        return trip;
    }

    public void setTrip(Trip trip) {
        this.trip = trip;
    }

    public Date getStartDate() {
        try {
            return new SimpleDateFormat("yyyy/MM/dd").parse(String.valueOf(startDate));
        } catch (Exception e) {
            return null;
        }
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

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

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}

    @Override
    public String toString() {
        return "OpenTripsDto{" +
                "id=" + id +
                ", trip=" + trip +
                ", startDate='" + startDate + '\'' +
                ", status=" + status +
                ", enableSeats=" + enableSeats +
                ", seatingSales=" + seatingSales +
                ", seatsDistribution='" + seatsDistribution + '\'' +
                '}';
    }
}