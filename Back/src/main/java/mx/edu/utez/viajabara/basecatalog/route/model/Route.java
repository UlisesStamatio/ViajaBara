package mx.edu.utez.viajabara.basecatalog.route.model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
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

    @ManyToOne
    @JoinColumn(name = "id_start_address")
    private Address startAddress;

    @ManyToOne
    @JoinColumn(name = "id_end_address")
    private Address endAddress;

    @Column(name = "distance_meters", columnDefinition = "DOUBLE")
    private double meters;


    @Column(name = "distance_time", columnDefinition = "DOUBLE")
    private double time;

    @OneToMany(mappedBy = "route")
    @JsonIgnore
    private List<Trip> trips;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @OneToMany(mappedBy = "route", cascade = CascadeType.ALL)
    private List<StopOver> stopOvers;

    public Route() {
    }


    public Route(Long id, Address startAddress, Address endAddress, double meters, double time) {
        this.id = id;
        this.startAddress = startAddress;
        this.endAddress = endAddress;
        this.meters = meters;
        this.time = time;
    }

    public Route(Address startAddress, Address endAddress, double meters, double time, boolean status) {
        this.startAddress = startAddress;
        this.endAddress = endAddress;
        this.meters = meters;
        this.time = time;
        this.status = status;
    }

    public Route(Address startAddress, Address endAddress, double meters, double time) {
        this.startAddress = startAddress;
        this.endAddress = endAddress;
        this.meters = meters;
        this.time = time;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    public Address getStartAddress() {
        return startAddress;
    }

    public void setStartAddress(Address startAddress) {
        this.startAddress = startAddress;
    }

    public Address getEndAddress() {
        return endAddress;
    }

    public void setEndAddress(Address endAddress) {
        this.endAddress = endAddress;
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