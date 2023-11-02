package mx.edu.utez.viajabara.basecatalog.stopover.model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "stopovers")
public class StopOver {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "latitude", columnDefinition = "VARCHAR(30)")
    private String latitude;

    @Column(name = "longitude", columnDefinition = "VARCHAR(30)")
    private String longitude;

    @Column(name = "sequence", columnDefinition = "INT(2)")
    private int sequence;

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

    public StopOver(String latitude, String longitude, int sequence, boolean status, Route route) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.sequence = sequence;
        this.status = status;
        this.route = route;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
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
}
