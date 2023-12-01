package mx.edu.utez.viajabara.basecatalog.seatingSales.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressDto;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteDto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;

public class SeatingSalesDto {

    @NotNull(groups = {Modify.class,Check.class})
    private Long id;
    @NotBlank(groups = {RouteDto.Register.class, RouteDto.Modify.class})
    private AddressDto startAddress;
    @NotBlank(groups = {RouteDto.Register.class, RouteDto.Modify.class})
    private AddressDto endAddress;
    @PositiveOrZero(groups = {Register.class,Modify.class})
    private double cost;
    @NotNull(groups = {Register.class,Modify.class})
    private String seatsSelected;
    @NotNull(groups = {Register.class,Modify.class,FindByClient.class})
    private User client;
    @NotNull(groups = {Register.class,Modify.class,FindByOpenTrip.class})
    private OpenTrips openTrips;
    @NotNull(groups = {Register.class,Modify.class})
    private int wholeTrip;

    @PositiveOrZero(groups = {Check.class})
    private int checked;

    public SeatingSalesDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public AddressDto getStartAddress() {
        return startAddress;
    }

    public void setStartAddress(AddressDto startAddress) {
        this.startAddress = startAddress;
    }

    public AddressDto getEndAddress() {
        return endAddress;
    }

    public void setEndAddress(AddressDto endAddress) {
        this.endAddress = endAddress;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }


    public User getClient() {
        return client;
    }

    public void setClient(User client) {
        this.client = client;
    }

    public OpenTrips getOpenTrips() {
        return openTrips;
    }

    public void setOpenTrips(OpenTrips openTrips) {
        this.openTrips = openTrips;
    }

    public int getChecked() {
        return checked;
    }

    public void setChecked(int checked) {
        this.checked = checked;
    }
    public String getSeatsSelected() {
        return seatsSelected;
    }

    public void setSeatsSelected(String seatsSelected) {
        this.seatsSelected = seatsSelected;
    }

    public int getWholeTrip() {
        return wholeTrip;
    }

    public void setWholeTrip(int wholeTrip) {
        this.wholeTrip = wholeTrip;
    }

    public interface Register{}
    public interface Modify{}
    public interface FindByClient{}
    public interface FindByOpenTrip{}
    public interface Check{}


    @Override
    public String toString() {
        return "SeatingSalesDto{" +
                "id=" + id +
                ", startAddress=" + startAddress +
                ", endAddress=" + endAddress +
                ", cost=" + cost +
                ", seating='" + seatsSelected + '\'' +
                ", client=" + client +
                ", openTrips=" + openTrips +
                ", wholeTrip=" + wholeTrip +
                '}';
    }
}
