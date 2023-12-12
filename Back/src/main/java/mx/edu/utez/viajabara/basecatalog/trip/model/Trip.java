package mx.edu.utez.viajabara.basecatalog.trip.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.way.model.Way;
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

    @OneToMany(mappedBy = "trip")
    @JsonIgnore
    private List<OpenTrips> trips;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @Column(name = "distance_meters", columnDefinition = "DOUBLE")
    private double meters;

    @Column(name = "distance_time", columnDefinition = "DOUBLE")
    private double time;

    @Column(columnDefinition = "time", name = "start_time")
    private Date startTime;
    @Column(name = "work_days", columnDefinition = "json")
    @Type(type = "json")
    private String workDays;

    @Column(name = "stopovers", columnDefinition = "json")
    @Type(type = "json")
    private String stopovers;

    @OneToMany(mappedBy = "trip")
    @JsonIgnore
    private List<Way> ways;


    public Trip() {
    }

    public Trip(Long id, List<Way> ways) {
        this.id = id;
        this.ways = ways;
    }

    public Trip(User driver, Bus bus, Route route, boolean status) {
        this.driver = driver;
        this.bus = bus;
        this.status = status;
    }

    public Trip(User driver, Bus bus, boolean status, double meters, double time, Date startTime, String workDays, String stopovers) {
        this.driver = driver;
        this.bus = bus;
        this.status = status;
        this.meters = meters;
        this.time = time;
        this.startTime = startTime;
        this.workDays = workDays;
        this.stopovers = stopovers;
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

    public String getStopovers() {
        return stopovers;
    }

    public void setStopovers(String stopovers) {
        this.stopovers = stopovers;
    }

    public double getMeters() {
        return meters;
    }

    public void setMeters(double meters) {
        this.meters = meters;
    }

    public double getTime() {
        return time;
    }

    public void setTime(double time) {
        this.time = time;
    }

    public List<Way> getWays() {
        return ways;
    }

    public void setWays(List<Way> ways) {
        this.ways = ways;
    }

    @Override
    public String toString() {
        return "Trip{" +
                "id=" + id +
                ", driver=" + driver +
                ", bus=" + bus +
                ", trips=" + trips +
                ", createdAt=" + createdAt +
                ", status=" + status +
                ", meters=" + meters +
                ", time=" + time +
                ", startTime=" + startTime +
                ", workDays='" + workDays + '\'' +
                ", stopovers='" + stopovers + '\'' +
                ", ways=" + ways +
                '}';
    }
}
