package mx.edu.utez.viajabara.basecatalog.seatingSales.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;

public class SeatingSalesDto {

    @NotNull(groups = {Modify.class})
    private Long id;
    @NotBlank(groups = {Register.class,Modify.class})
    private String start_latitude;
    @NotBlank(groups = {Register.class,Modify.class})
    private String start_longitude;
    @NotBlank(groups = {Register.class,Modify.class})
    private String end_latitude;
    @NotBlank(groups = {Register.class,Modify.class})
    private String end_longitude;
    @PositiveOrZero(groups = {Register.class,Modify.class})
    private double cost;
    @PositiveOrZero(groups = {Register.class,Modify.class})
    private int seating;
    @NotNull(groups = {Register.class,Modify.class,FindByClient.class})
    private User client;
    @NotNull(groups = {Register.class,Modify.class,FindByOpenTrip.class})
    private OpenTrips openTrips;

    public SeatingSalesDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStart_latitude() {
        return start_latitude;
    }

    public void setStart_latitude(String start_latitude) {
        this.start_latitude = start_latitude;
    }

    public String getStart_longitude() {
        return start_longitude;
    }

    public void setStart_longitude(String start_longitude) {
        this.start_longitude = start_longitude;
    }

    public String getEnd_latitude() {
        return end_latitude;
    }

    public void setEnd_latitude(String end_latitude) {
        this.end_latitude = end_latitude;
    }

    public String getEnd_longitude() {
        return end_longitude;
    }

    public void setEnd_longitude(String end_longitude) {
        this.end_longitude = end_longitude;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public int getSeating() {
        return seating;
    }

    public void setSeating(int seating) {
        this.seating = seating;
    }

    public User getClient() {
        return client;
    }

    public void setClient(User client) {
        this.client = client;
    }

    public OpenTrips getOpenTrips() {
        return openTrips;
    }

    public void setOpenTrips(OpenTrips openTrips) {
        this.openTrips = openTrips;
    }

    public interface Register{}
    public interface Modify{}
    public interface FindByClient{}
    public interface FindByOpenTrip{}
}
