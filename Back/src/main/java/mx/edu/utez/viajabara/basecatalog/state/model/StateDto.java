package mx.edu.utez.viajabara.basecatalog.state.model;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.stream.Collectors;

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

    public static List<StateDto> fromList(List<State> states) {
        return states.stream()
                .map(StateDto::from)
                .collect(Collectors.toList());
    }

    public static StateDto from(State state) {
        StateDto stateDto = new StateDto();
        stateDto.setId(state.getId());
        stateDto.setName(state.getName());
        return stateDto;
    }
}