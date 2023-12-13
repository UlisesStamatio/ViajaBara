package mx.edu.utez.viajabara.basecatalog.paymentMethod.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

public class PaymentMethodDto {
    @NotNull(groups = {Modify.class, ChangeStatus.class})
    private Long id;

    @NotBlank(groups = {Register.class, Modify.class})
    private String name;

    private String apikey;

    public PaymentMethodDto() {
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

    public String getApikey() {
        return apikey;
    }

    public void setApikey(String apikey) {
        this.apikey = apikey;
    }

    public interface Register{}
    public interface Modify{}
    public interface ChangeStatus{}
}
