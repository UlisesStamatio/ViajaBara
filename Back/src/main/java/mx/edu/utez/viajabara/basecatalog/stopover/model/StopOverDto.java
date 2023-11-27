package mx.edu.utez.viajabara.basecatalog.stopover.model;

import mx.edu.utez.viajabara.basecatalog.address.model.Address;

import javax.persistence.*;
import java.util.Date;

public class StopOverDto {

    private Long id;
    private String latitude;
    private String longitude;
    private String description;
    private String state;
    private int sequence;
    private double meters;
    private double time;

    public StopOverDto() {
    }

    public StopOverDto(Long id, String latitude, String longitude, String description, String state, int sequence, double meters, double time) {
        this.id = id;
        this.latitude = latitude;
        this.longitude = longitude;
        this.description = description;
        this.state = state;
        this.sequence = sequence;
        this.meters = meters;
        this.time = time;
    }

    public StopOverDto(String latitude, String longitude, String description, String state, int sequence, double meters, double time) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.description = description;
        this.sequence = sequence;
        this.meters = meters;
        this.time = time;
        this.state = state;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }


}
