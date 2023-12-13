package mx.edu.utez.viajabara.basecatalog.address.model;

import mx.edu.utez.viajabara.basecatalog.state.model.StateDto;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


public class AddressDto {


    private Long id;

    private String latitude;


    private String longitude;


    private String description;


    private StateDto state;




    public AddressDto() {
    }

    public AddressDto(Long id, String latitude, String longitude, String description, StateDto state, Date createdAt) {
        this.id = id;
        this.latitude = latitude;
        this.longitude = longitude;
        this.description = description;
        this.state = state;
    }

    public AddressDto( String latitude, String longitude, String description, StateDto state) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.description = description;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public StateDto getState() {
        return state;
    }

    public void setState(StateDto state) {
        this.state = state;
    }

    public static List<AddressDto> fromList(List<Address> addresses) {
        return addresses.stream()
                .map(AddressDto::from)
                .collect(Collectors.toList());
    }

    public static AddressDto from(Address address) {
        AddressDto addressDto = new AddressDto();
        addressDto.setId(address.getId());
        addressDto.setLatitude(address.getLatitude());
        addressDto.setLongitude(address.getLongitude());
        addressDto.setDescription(address.getDescription());
        addressDto.setState(StateDto.from(address.getState()));
        return addressDto;
    }
}