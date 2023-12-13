package mx.edu.utez.viajabara.basecatalog.route.model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOver;
import mx.edu.utez.viajabara.basecatalog.way.model.Way;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "routes")
public class Route {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", columnDefinition = "VARCHAR(45)")
    private String name;

    @Column(name = "distance_meters", columnDefinition = "DOUBLE")
    private double meters;

    @Column(name = "distance_time", columnDefinition = "DOUBLE")
    private double time;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @OneToMany(mappedBy = "route",cascade = CascadeType.ALL)
    private List<StopOver> stopOvers;

    @OneToMany(mappedBy = "route")
    @JsonIgnore
    private List<Way> ways;


    public Route() {
    }


    public Route(Long id, String name, double meters, double time) {
        this.id = id;
        this.meters = meters;
        this.time = time;
        this.name = name;
    }

    public Route( String name, double meters, double time, boolean status) {
        this.meters = meters;
        this.time = time;
        this.status = status;
        this.name = name;
    }

    public Route(String name, double meters, double time) {
        this.name = name;
        this.meters = meters;
        this.time = time;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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