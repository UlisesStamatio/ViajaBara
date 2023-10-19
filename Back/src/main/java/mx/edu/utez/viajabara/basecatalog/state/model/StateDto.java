package mx.edu.utez.viajabara.basecatalog.state.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

public class StateDto {
    @NotNull(groups = {Modify.class, ChangeStatus.class})
    private Long id;
    @NotBlank(groups = {Modify.class, Register.class})
    private String name;

    public StateDto() {
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

    public interface Register {
    }

    public interface Modify {
    }

    public interface ChangeStatus {
    }
}
