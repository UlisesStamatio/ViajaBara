package mx.edu.utez.viajabara.access.visualconfig.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;

public class VisualConfigDto {
    @NotNull(groups = {Modify.class, ChangeStatus.class})
    private Long id;
    @NotBlank(groups = {Modify.class, Register.class})
    private String backgroundAside;
    @NotBlank(groups = {Modify.class, Register.class})
    private String textAside;
    @NotBlank(groups = {Modify.class, Register.class})
    private String logo;
    @PositiveOrZero(groups = {Modify.class, Register.class})
    private double kilometerPrice;

    public VisualConfigDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBackgroundAside() {
        return backgroundAside;
    }

    public void setBackgroundAside(String backgroundAside) {
        this.backgroundAside = backgroundAside;
    }

    public String getTextAside() {
        return textAside;
    }

    public void setTextAside(String textAside) {
        this.textAside = textAside;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public double getKilometerPrice() {
        return kilometerPrice;
    }

    public void setKilometerPrice(float kilometerPrice) {
        this.kilometerPrice = kilometerPrice;
    }

    public interface Register {
    }

    public interface Modify {
    }

    public interface ChangeStatus {
    }
}
