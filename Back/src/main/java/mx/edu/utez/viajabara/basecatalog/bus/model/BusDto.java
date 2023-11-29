package mx.edu.utez.viajabara.basecatalog.bus.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

public class BusDto {

    @NotNull(groups = {Modify.class,ChangeStatus.class})
    private Long id;
    private String image;
    @NotBlank(groups = {Register.class,Modify.class})
    private String plaque;
    @NotBlank(groups = {Register.class,Modify.class})
    private String mark;
    @NotBlank(groups = {Register.class,Modify.class})
    private String model;
    private String serial;
    private String fuel;

    public BusDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getPlaque() {
        return plaque;
    }

    public void setPlaque(String plaque) {
        this.plaque = plaque;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getFuel() {
        return fuel;
    }

    public void setFuel(String fuel) {
        this.fuel = fuel;
    }

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}
}
