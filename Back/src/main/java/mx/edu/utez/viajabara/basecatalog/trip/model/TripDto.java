package mx.edu.utez.viajabara.basecatalog.trip.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.way.model.Way;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
    @Min(value = 0, groups = {Register.class, Modify.class})
    private double time;
    @Min(value = 0, groups = {Register.class, Modify.class})
    private double meters;
    @NotNull(groups = {Register.class,Modify.class})
    private String stopovers;
    @NotNull(groups = {Register.class,Modify.class})
    private String workDays;
    @NotNull(groups = {Register.class,Modify.class})
    private List<Way> ways;

    private FilterType filterType;
    private Date endTime;

    private int enabledSeats;

    public TripDto() {
    }

    public TripDto(Long id) {
        this.id = id;
    }

    public TripDto(Long id, List<Way> ways) {
        this.id = id;
        this.ways = ways;
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


    public List<Way> getWays() {
        return ways;
    }

    public void setWays(List<Way> ways) {
        this.ways = ways;
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

    public double getTime() {
        return time;
    }

    public void setTime(double time) {
        this.time = time;
    }

    public double getMeters() {
        return meters;
    }

    public void setMeters(double meters) {
        this.meters = meters;
    }

    public String getStopovers() {
        return stopovers;
    }

    public void setStopovers(String stopovers) {
        this.stopovers = stopovers;
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
        tripDto.setTime(trip.getTime());
        tripDto.setMeters(trip.getMeters());
        tripDto.setWays(trip.getWays());
        tripDto.setWorkDays(trip.getWorkDays());
        tripDto.setStopovers(trip.getStopovers());
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
