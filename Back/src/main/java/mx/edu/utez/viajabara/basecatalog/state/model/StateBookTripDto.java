package mx.edu.utez.viajabara.basecatalog.state.model;

import mx.edu.utez.viajabara.basecatalog.address.model.AddressDto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.stream.Collectors;

public class StateBookTripDto {
    @NotNull(groups = {Modify.class, ChangeStatus.class})
    private Long id;
    @NotBlank(groups = {Modify.class, Register.class})
    private String name;
    @NotBlank(groups = {Modify.class, Register.class})
    private List<AddressDto> addresses;

    public StateBookTripDto() {
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

    public List<AddressDto> getAddressDtos() {
        return addresses;
    }

    public void setAddressDtos(List<AddressDto> addresses) {
        this.addresses = addresses;
    }

    public interface Register {
    }

    public interface Modify {
    }

    public interface ChangeStatus {
    }

    public static List<StateBookTripDto> fromList(List<State> states) {
        return states.stream()
                .map(StateBookTripDto::from)
                .collect(Collectors.toList());
    }

    public static StateBookTripDto from(State state) {
        StateBookTripDto stateDto = new StateBookTripDto();
        stateDto.setId(state.getId());
        stateDto.setName(state.getName());
        stateDto.setAddressDtos(AddressDto.fromList(state.getAddresses()));
        return stateDto;
    }

    @Override
    public String toString() {
        return "StateBookTripDto{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", addresses=" + addresses +
                '}';
    }
}