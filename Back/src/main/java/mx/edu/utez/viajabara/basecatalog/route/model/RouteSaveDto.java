package mx.edu.utez.viajabara.basecatalog.route.model;

import mx.edu.utez.viajabara.basecatalog.address.model.AddressDto;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressSaveDto;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOverDto;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOverSaveDto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

public class RouteSaveDto {

    @NotNull(groups = {Modify.class,ChangeStatus.class})
    private Long id;
    @NotBlank(groups = {Register.class,Modify.class})
    private String name;
    @Min(value = 0, groups = {Register.class,Modify.class})
    private double meters;
    @Min(value = 0, groups = {Register.class,Modify.class})
    private double time;
    List<StopOverSaveDto> stopOvers;

    public RouteSaveDto() {
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

    public List<StopOverSaveDto> getStopOvers() {
        return stopOvers;
    }

    public void setStopOvers(List<StopOverSaveDto> stopOvers) {
        this.stopOvers = stopOvers;
    }

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}

}