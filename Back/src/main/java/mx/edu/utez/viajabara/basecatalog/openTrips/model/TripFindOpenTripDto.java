package mx.edu.utez.viajabara.basecatalog.openTrips.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteDto;
import mx.edu.utez.viajabara.basecatalog.trip.model.FilterType;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;

import javax.validation.constraints.NotNull;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;


public class TripFindOpenTripDto {
    private Long id;
    private String startDate;

    public TripFindOpenTripDto() {
    }

    public TripFindOpenTripDto(Long id, String startDate) {
        this.id = id;
        this.startDate = startDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
}
