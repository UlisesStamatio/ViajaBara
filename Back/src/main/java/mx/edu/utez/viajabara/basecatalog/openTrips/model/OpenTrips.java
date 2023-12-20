package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripSchedule;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "open_trips")
public class OpenTrips {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private TripSchedule schedule;


    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    //1.-En espera 2.-En curso 3.-Finalizado
    @Column(name = "status", columnDefinition = "INT(1)")
    private int status;


    @OneToMany(mappedBy = "openTrips")
    @JsonIgnore
    private List<SeatingSales> seatingSales;

    @Column(name = "enable_seats", columnDefinition = "INT(2) DEFAULT 20")
    private int enableSeats;

    public OpenTrips() {
    }

    public OpenTrips(TripSchedule schedule, int status, int enableSeats) {
        this.schedule = schedule;
        this.status = status;
        this.enableSeats = enableSeats;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }



    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getEnableSeats() {
        return enableSeats;
    }

    public void setEnableSeats(int enableSeats) {
        this.enableSeats = enableSeats;
    }

    public List<SeatingSales> getSeatingSales() {
        return seatingSales;
    }

    public void setSeatingSales(List<SeatingSales> seatingSales) {
        this.seatingSales = seatingSales;
    }

    public TripSchedule getSchedule() {
        return schedule;
    }

    public void setSchedule(TripSchedule schedule) {
        this.schedule = schedule;
    }
}
