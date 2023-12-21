package mx.edu.utez.viajabara.basecatalog.tripSchedule.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.way.model.Way;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "trip_schedule")
public class TripSchedule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @Column(columnDefinition = "TIMESTAMP", name = "start_date")
    private Date startDate;

    @Column(columnDefinition = "TIMESTAMP", name = "end_date")
    private Date  endDate;

    @ManyToOne
    @JoinColumn(name = "trip_id")
    @JsonIgnore
    private Trip trip;


    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @OneToMany(mappedBy = "schedule")
    @JsonIgnore
    private List<OpenTrips> openTrips;

    public TripSchedule() {
    }

    public TripSchedule(Date  startDate, Date  endDate,Trip trip, boolean status) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.trip = trip;
    }

    public TripSchedule(Long id, Date  startDate, Date  endDate, boolean status) {
        this.id = id;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date  getStartDate() {
        return startDate;
    }

    public void setStartDate(Date  startDate) {
        this.startDate = startDate;
    }

    public Date  getEndDate() {
        return endDate;
    }

    public void setEndDate(Date  endDate) {
        this.endDate = endDate;
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

    public Trip getTrip() {
        return trip;
    }

    public void setTrip(Trip trip) {
        this.trip = trip;
    }

    public boolean intersects(TripSchedule tripSchedule) {
        return !(this.endDate.compareTo(tripSchedule.getStartDate()) <= 0 || this.startDate.compareTo(tripSchedule.getEndDate()) >= 0);
    }
}
