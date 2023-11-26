package mx.edu.utez.viajabara.basecatalog.stopover.model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "stopovers")
public class StopOver {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_address")
    private Address address;

    @Column(name = "sequence", columnDefinition = "INT(2)")
    private int sequence;

    @Column(name = "distance_meters", columnDefinition = "DOUBLE")
    private double meters;


    @Column(name = "distance_time", columnDefinition = "DOUBLE")
    private double time;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @ManyToOne
    @JsonIgnore
    private Route route;

    public StopOver() {
    }

    public StopOver(Address address, int sequence, double meters, double time, boolean status, Route route) {
        this.address = address;
        this.sequence = sequence;
        this.meters = meters;
        this.time = time;
        this.status = status;
        this.route = route;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public int getSequence() {
        return sequence;
    }

    public void setSequence(int sequence) {
        this.sequence = sequence;
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

    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
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
}
