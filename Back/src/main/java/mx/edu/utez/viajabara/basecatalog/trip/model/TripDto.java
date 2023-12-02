package mx.edu.utez.viajabara.basecatalog.trip.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteDto;

import javax.validation.constraints.NotNull;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import java.util.stream.Collectors;


public class TripDto {
    @NotNull(groups = {Modify.class,ChangeStatus.class})
    private Long id;
    @NotNull(groups = {Register.class,Modify.class,FindByDriver.class})
    private User driver;
    @NotNull(groups = {Register.class,Modify.class})
    private Bus bus;
    @NotNull(groups = {Register.class,Modify.class,GetByDate.class})
    private Date startTime;

    private Date endTime;
    @NotNull(groups = {Register.class,Modify.class})
    private String workDays;
    @NotNull(groups = {Register.class,Modify.class})
    private RouteDto route;
    private FilterType filterType;

    private int enabledSeats;

    public TripDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getDriver() {
        return driver;
    }

    public void setDriver(User driver) {
        this.driver = driver;
    }

    public Bus getBus() {
        return bus;
    }

    public void setBus(Bus bus) {
        this.bus = bus;
    }

    public RouteDto getRoute() {
        return route;
    }

    public void setRoute(RouteDto route) {
        this.route = route;
    }

    public Date getStartTime() {
        return parseDate(startTime);
    }

    public void setStartTime(Date startTime) {
        this.startTime = parseDate(startTime);
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getWorkDays() {
        return workDays;
    }

    public void setWorkDays(String workDays) {
        this.workDays = workDays;
    }

    public FilterType getFilterType() {
        return filterType;
    }

    public int getEnabledSeats() {
        return enabledSeats;
    }

    public void setEnabledSeats(int enabledSeats) {
        this.enabledSeats = enabledSeats;
    }

    public void setFilterType(FilterType filterType) {
        this.filterType = filterType;
    }
    public static List<TripDto> fromList(List<Trip> trips) {
        return trips.stream()
                .map(TripDto::from)
                .collect(Collectors.toList());
    }

    public static TripDto from(Trip trip) {
        TripDto tripDto = new TripDto();
        tripDto.setId(trip.getId());
        tripDto.setDriver(trip.getDriver());
        tripDto.setBus(trip.getBus());
        tripDto.setStartTime(trip.getStartTime());
        tripDto.setRoute(RouteDto.from(trip.getRoute(), trip.getStartTime()));
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(trip.getStartTime());
        calendar.add(Calendar.MINUTE, (int) tripDto.getRoute().getTime());
        tripDto.setEndTime(calendar.getTime());
        tripDto.setWorkDays(trip.getWorkDays());
        return tripDto;
    }

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}
    public interface FindByDriver{}
    public interface GetByDate{}

    private Date parseDate(Date date) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
            sdf.setTimeZone(TimeZone.getTimeZone("America/Mexico_City"));
            return sdf.parse(sdf.format(date));
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

}
