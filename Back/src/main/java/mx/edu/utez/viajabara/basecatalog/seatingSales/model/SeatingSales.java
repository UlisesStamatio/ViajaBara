package mx.edu.utez.viajabara.basecatalog.seatingSales.model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.qualifications.model.Qualifications;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "seatings_sales")
public class SeatingSales {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "id_start_address")
    private Address startAddress;

    @ManyToOne
    @JoinColumn(name = "id_end_address")
    private Address endAddress;

    @Column(name = "cost", columnDefinition = "FLOAT(5,2)")
    private double cost;

    @ManyToOne
    private User client;

    @Column(name = "seats_selected", columnDefinition = "json")
    @Type(type = "json")
    private String seatsSelected;
    @ManyToOne
    private OpenTrips openTrips;

    @OneToMany(mappedBy = "seatingSales")
    @JsonIgnore
    private List<Qualifications> qualifications;

    @Column(name = "wholeTrip", columnDefinition = "INT(1)")
    private int wholeTrip;

    public SeatingSales() {
    }

    public SeatingSales(Address startAddress, Address endAddress, double cost) {
        this.startAddress = startAddress;
        this.endAddress = endAddress;
        this.cost = cost;
    }

    public SeatingSales(Address startAddress, Address endAddress, double cost, User client, String seatsSelected, int wholeTrip, OpenTrips openTrips ) {
        this.startAddress = startAddress;
        this.endAddress = endAddress;
        this.cost = cost;
        this.client = client;
        this.seatsSelected = seatsSelected;
        this.wholeTrip = wholeTrip;
        this.openTrips = openTrips;
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

    public OpenTrips getOpenTrips() {
        return openTrips;
    }

    public void setOpenTrips(OpenTrips openTrips) {
        this.openTrips = openTrips;
    }

    public String getSeatsSelected() {
        return seatsSelected;
    }

    public void setSeatsSelected(String seatsSelected) {
        this.seatsSelected = seatsSelected;
    }

    public int getWholeTrip() {
        return wholeTrip;
    }

    public void setWholeTrip(int wholeTrip) {
        this.wholeTrip = wholeTrip;
    }
}