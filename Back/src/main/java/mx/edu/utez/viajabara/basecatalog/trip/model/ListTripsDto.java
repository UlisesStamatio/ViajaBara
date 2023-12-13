package mx.edu.utez.viajabara.basecatalog.trip.model;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.way.model.Way;
import java.util.Date;
import java.util.List;

public class ListTripsDto {
    private Long id;

    private User driver;

    private Bus bus;

    private Date createdAt;

    private boolean status;

    private double meters;

    private double time;

    private Date startTime;

    private String workDays;

    private String stopovers;

    private List<Way> ways;

    public ListTripsDto() {
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

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String getWorkDays() {
        return workDays;
    }

    public void setWorkDays(String workDays) {
        this.workDays = workDays;
    }

    public String getStopovers() {
        return stopovers;
    }

    public void setStopovers(String stopovers) {
        this.stopovers = stopovers;
    }

    public List<Way> getWays() {
        return ways;
    }

    public void setWays(List<Way> ways) {
        this.ways = ways;
    }
}
