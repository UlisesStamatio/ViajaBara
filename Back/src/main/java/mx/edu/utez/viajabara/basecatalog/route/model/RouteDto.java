package mx.edu.utez.viajabara.basecatalog.route.model;

import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOverDto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

public class RouteDto {

    @NotNull(groups = {Modify.class,ChangeStatus.class})
    private Long id;
    @NotBlank(groups = {Register.class,Modify.class})
    private String name;
    @Min(value = 0, groups = {Register.class,Modify.class})
    private double meters;
    @Min(value = 0, groups = {Register.class,Modify.class})
    private double time;
    List<StopOverDto> stopOvers;

    public RouteDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public List<StopOverDto> getStopOvers() {
        return stopOvers;
    }

    public void setStopOvers(List<StopOverDto> stopOvers) {
        this.stopOvers = stopOvers;
    }

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}

    public static RouteDto from(Route route, Date initialTimeRoute) {
        RouteDto routeDto = new RouteDto();
        routeDto.setId(route.getId());
        routeDto.setName(routeDto.getName());
        routeDto.setMeters(route.getMeters());
        routeDto.setTime(route.getTime());
        routeDto.setStopOvers(StopOverDto.fromList(route.getStopOvers(), initialTimeRoute));
        return routeDto;
    }
}