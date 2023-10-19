package mx.edu.utez.viajabara.basecatalog.bus.model;


import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.seating.model.Seating;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "buses")
public class Bus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "image", columnDefinition = "LONGTEXT")
    private String image;

    @Column(name = "plaque", columnDefinition = "VARCHAR(13)")
    private String plaque;

    @Column(name = "mark", columnDefinition = "VARCHAR(50)")
    private String mark;

    @Column(name = "model", columnDefinition = "VARCHAR(50)")
    private String model;

    @Column(name = "serial", columnDefinition = "VARCHAR(13)")
    private String serial;

    @Column(name = "fuel", columnDefinition = "VARCHAR(13)")
    private String fuel;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;


    @OneToMany(mappedBy = "bus")
    @JsonIgnore
    private List<Seating> seatings;

    @OneToMany(mappedBy = "bus")
    @JsonIgnore
    private List<Trip> trips;

    public Bus() {
    }

    public Bus(String image, String plaque, String mark, String model, String serial, String fuel, boolean status) {
        this.image = image;
        this.plaque = plaque;
        this.mark = mark;
        this.model = model;
        this.serial = serial;
        this.fuel = fuel;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getPlaque() {
        return plaque;
    }

    public void setPlaque(String plaque) {
        this.plaque = plaque;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getFuel() {
        return fuel;
    }

    public void setFuel(String fuel) {
        this.fuel = fuel;
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
}
