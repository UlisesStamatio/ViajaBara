package mx.edu.utez.viajabara.basecatalog.address.model;

import mx.edu.utez.viajabara.basecatalog.state.model.State;

import javax.persistence.*;
import java.util.Date;



public class AddressDto {


    private Long id;

    private String latitude;


    private String longitude;


    private String description;


    private String state;


    public AddressDto() {
    }

    public AddressDto(Long id, String latitude, String longitude, String description, String state, Date createdAt) {
        this.id = id;
        this.latitude = latitude;
        this.longitude = longitude;
        this.description = description;
        this.state = state;
    }

    public AddressDto( String latitude, String longitude, String description, String state) {
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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }


}
