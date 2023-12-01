package mx.edu.utez.viajabara.basecatalog.stopover.model;

import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressDto;
import mx.edu.utez.viajabara.basecatalog.state.model.StateDto;

import javax.persistence.*;
import java.sql.Time;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class StopOverDto {

    private Long id;
    private AddressDto addressDto;
    private String description;
    private StateDto state;
    private int sequence;
    private double meters;
    private double time;
    private Date timeAccordingStart;

    public StopOverDto() {
    }

    public StopOverDto(AddressDto addressDto, String description, StateDto state, int sequence, double meters, double time) {
        this.addressDto = addressDto;
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

    public AddressDto getAddressDto() {
        return addressDto;
    }

    public void setAddressDto(AddressDto addressDto) {
        this.addressDto = addressDto;
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

    public StateDto getState() {
        return state;
    }

    public void setState(StateDto state) {
        this.state = state;
    }

    public Date getTimeAccordingStart() {
        return timeAccordingStart;
    }

    public void setTimeAccordingStart(Date timeAccordingStart) {
        this.timeAccordingStart = timeAccordingStart;
    }

    public static List<StopOverDto> fromList(List<StopOver> stopOvers, Date initialTimeRoute) {
        return stopOvers.stream()
                .map(stopOver -> from(stopOver, initialTimeRoute))
                .collect(Collectors.toList());
    }

    public static StopOverDto from(StopOver stopOver, Date initialTime) {
        StopOverDto stopOverDto = new StopOverDto();
        stopOverDto.setId(stopOver.getId());
        stopOverDto.setAddressDto(AddressDto.from(stopOver.getAddress()));
        stopOverDto.setDescription(stopOver.getAddress().getDescription());
        stopOverDto.setState(StateDto.from(stopOver.getAddress().getState()));
        stopOverDto.setSequence(stopOver.getSequence());
        stopOverDto.setMeters(stopOver.getMeters());
        stopOverDto.setTime(stopOver.getTime());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(initialTime);
        calendar.add(Calendar.MINUTE, (int) stopOver.getTime());
        stopOverDto.setTimeAccordingStart(calendar.getTime());
        return stopOverDto;
    }
}