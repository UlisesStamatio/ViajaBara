package mx.edu.utez.viajabara.basecatalog.route.model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.duty.model.Duty;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOver;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "routes")
public class Route {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "start_latitude", columnDefinition = "VARCHAR(30)")
    private String start_latitude;

    @Column(name = "start_longitude", columnDefinition = "VARCHAR(30)")
    private String start_longitude;

    @Column(name = "end_latitude", columnDefinition = "VARCHAR(30)")
    private String end_latitude;

    @Column(name = "end_longitude", columnDefinition = "VARCHAR(30)")
    private String end_longitude;

    @ManyToOne
    private Duty duty;

    @OneToMany(mappedBy = "route")
    @JsonIgnore
    private List<Trip> trips;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @OneToMany(mappedBy = "route")
    private List<StopOver> stopOvers;

    public Route() {
    }

    public Route(String start_latitude, String start_longitude, String end_latitude, String end_longitude, Duty duty, boolean status) {
        this.start_latitude = start_latitude;
        this.start_longitude = start_longitude;
        this.end_latitude = end_latitude;
        this.end_longitude = end_longitude;
        this.duty = duty;
        this.status = status;
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

    public Duty getDuty() {
        return duty;
    }

    public void setDuty(Duty duty) {
        this.duty = duty;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public List<StopOver> getStopOvers() {
        return stopOvers;
    }

    public void setStopOvers(List<StopOver> stopOvers) {
        this.stopOvers = stopOvers;
    }
}
