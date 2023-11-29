package mx.edu.utez.viajabara.basecatalog.trip.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "trips")
public class Trip {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @ManyToOne
    private User driver;

    @ManyToOne
    private Bus bus;

    @ManyToOne
    private Route route;

    @OneToMany(mappedBy = "trip")
    @JsonIgnore
    private List<OpenTrips> trips;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @Column(columnDefinition = "time", name = "start_time")
    private Date startTime;
    @Column(name = "work_days", columnDefinition = "json")
    @Type(type = "json")
    private String workDays;

    public Trip() {
    }

    public Trip(User driver, Bus bus, Route route, boolean status) {
        this.driver = driver;
        this.bus = bus;
        this.route = route;
        this.status = status;
    }

    public Trip(User driver, Bus bus, Route route, boolean status, Date startTime, String workDays) {
        this.driver = driver;
        this.bus = bus;
        this.route = route;
        this.status = status;
        this.startTime = startTime;
        this.workDays = workDays;
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

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String getWorkDays() {
        return workDays;
    }

    public void setWorkDays(String workDays) {
        this.workDays = workDays;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
