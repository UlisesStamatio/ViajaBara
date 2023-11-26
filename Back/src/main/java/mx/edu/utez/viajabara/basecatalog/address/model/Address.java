package mx.edu.utez.viajabara.basecatalog.address.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.state.model.State;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOver;

import javax.persistence.*;
import java.util.Date;
import java.util.List;


@Entity
@Table(name = "adresses")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "latitude", columnDefinition = "VARCHAR(30)")
    private String latitude;

    @Column(name = "longitude", columnDefinition = "VARCHAR(30)")
    private String longitude;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @ManyToOne
    @JoinColumn(name = "id_state")
    private State state;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;


    @OneToMany(mappedBy = "startAddress")
    @JsonIgnore
    private List<Route> routesStart;

    @OneToMany(mappedBy = "endAddress")
    @JsonIgnore
    private List<Route> routesEnd;

    @OneToMany(mappedBy = "address")
    @JsonIgnore
    private List<StopOver> stopOvers;


    public Address() {
    }

    public Address(String latitude, String longitude, String description, State state) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.description = description;
        this.state = state;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
