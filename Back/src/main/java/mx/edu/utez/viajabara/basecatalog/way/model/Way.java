package mx.edu.utez.viajabara.basecatalog.way.model;

import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Table(name = "ways")
public class Way {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "route_id")
    private Route route;

    @ManyToOne
    @JoinColumn(name = "trip_id")
    private Trip trip;

    @Column(name = "sequence", columnDefinition = "INT(2)")
    private int sequence;


    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public Way() {
    }

    public Way(Long id, Route route, Trip trip, int sequence, boolean status) {
        this.id = id;
        this.route = route;
        this.trip = trip;
        this.sequence = sequence;
        this.status = status;
    }

    public Way(Route route, Trip trip, int sequence, boolean status) {
        this.route = route;
        this.trip = trip;
        this.sequence = sequence;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }

    public Trip getTrip() {
        return trip;
    }

    public void setTrip(Trip trip) {
        this.trip = trip;
    }

    public int getSequence() {
        return sequence;
    }

    public void setSequence(int sequence) {
        this.sequence = sequence;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public static List<Way> fromListToBookSelect(List<Way> ways) {
        return ways.stream()
                .map(Way::fromToBookSelect)
                .collect(Collectors.toList());
    }

    public static Way fromToBookSelect(Way way) {
        Way wayBook = new Way();
        wayBook.setId(way.getId());
        wayBook.setRoute(way.route);
        wayBook.setSequence(way.getSequence());
        return wayBook;
    }
}
