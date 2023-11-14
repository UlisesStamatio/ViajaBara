package mx.edu.utez.viajabara.basecatalog.trip.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;

import javax.validation.constraints.NotNull;

public class TripDto {
    @NotNull(groups = {Modify.class,ChangeStatus.class})
    private Long id;
    @NotNull(groups = {Register.class,Modify.class})
    private User driver;
    @NotNull(groups = {Register.class,Modify.class})
    private Bus bus;
    @NotNull(groups = {Register.class,Modify.class})
    private Route route;

    public TripDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getDriver() {
        return driver;
    }

    public void setDriver(User driver) {
        this.driver = driver;
    }

    public Bus getBus() {
        return bus;
    }

    public void setBus(Bus bus) {
        this.bus = bus;
    }

    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}
}
