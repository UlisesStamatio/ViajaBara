package mx.edu.utez.viajabara.basecatalog.seatingSales.model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.qualifications.model.Qualifications;
import mx.edu.utez.viajabara.basecatalog.seating.model.Seating;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "seatings_sales")
public class SeatingSales {
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

    @Column(name = "cost", columnDefinition = "FLOAT(5,2)")
    private double cost;

    @ManyToOne
    private User client;

    @ManyToOne
    private Seating seating;

    @ManyToOne
    private OpenTrips openTrips;

    @OneToMany(mappedBy = "seatingSales")
    @JsonIgnore
    private List<Qualifications> qualifications;


    public SeatingSales() {
    }

    public SeatingSales(String start_latitude, String start_longitude, String end_latitude, String end_longitude, double cost) {
        this.start_latitude = start_latitude;
        this.start_longitude = start_longitude;
        this.end_latitude = end_latitude;
        this.end_longitude = end_longitude;
        this.cost = cost;
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

    public User getClient() {
        return client;
    }

    public void setClient(User client) {
        this.client = client;
    }

    public Seating getSeating() {
        return seating;
    }

    public void setSeating(Seating seating) {
        this.seating = seating;
    }

    public OpenTrips getOpenTrips() {
        return openTrips;
    }

    public void setOpenTrips(OpenTrips openTrips) {
        this.openTrips = openTrips;
    }
}
