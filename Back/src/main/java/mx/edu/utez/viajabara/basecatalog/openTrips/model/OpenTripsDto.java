package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.utils.validator.CheckDateFormat;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;
import java.text.SimpleDateFormat;
import java.util.Date;

public class OpenTripsDto {
    @NotNull(groups = {Modify.class,ChangeStatus.class})
    private Long id;
    @NotNull(groups = {Register.class,Modify.class})
    private Trip trip;
    @CheckDateFormat(pattern = "yyyy/MM/dd",groups = {Register.class,Modify.class})
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private String startDate;

    @PositiveOrZero(groups = {Modify.class,ChangeStatus.class})
    private int status;

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

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}
}
