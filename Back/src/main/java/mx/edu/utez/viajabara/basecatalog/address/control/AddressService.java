package mx.edu.utez.viajabara.basecatalog.address.control;

import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressDto;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressRepository;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressSaveDto;
import mx.edu.utez.viajabara.basecatalog.paymentMethod.model.PaymentMethod;
import mx.edu.utez.viajabara.basecatalog.paymentMethod.model.PaymentMethodDto;
import mx.edu.utez.viajabara.basecatalog.state.control.StateService;
import mx.edu.utez.viajabara.basecatalog.state.model.State;
import mx.edu.utez.viajabara.utils.entity.Message;
import mx.edu.utez.viajabara.utils.entity.TypesResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.Optional;

@Transactional
@Service
public class AddressService {

    private final static Logger logger = LoggerFactory.getLogger(AddressService.class);

    private final AddressRepository repository;

    private final StateService serviceState;

    @Autowired
    public AddressService(AddressRepository repository, StateService service) {
        this.repository = repository;
        this.serviceState = service;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        return new ResponseEntity<>(new Message(repository.findAll(), "Listado de direcciones", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(readOnly = true)
    public Optional<Address> findById(Long id) {
        return repository.findById(id);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(Long id) {
        Optional<Address> optionalAddress = repository.findById(id);
        return optionalAddress.<ResponseEntity<Object>>map(address -> new ResponseEntity<>(new Message(address, "Dirección encontrada", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Dirección no encontrada", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

    @Transactional(rollbackFor = {SQLException.class})
    public Address save(AddressSaveDto dto) throws SQLException {
        Optional<Address> optional = repository.findByLatitudeAndLongitude(dto.getLatitude(), dto.getLongitude());
        if (optional.isPresent()) {
            return optional.get();
        }else{
            Optional<State> state = serviceState.findByName(dto.getState().toLowerCase());
            if(state.isPresent()){
                Address address = new Address(dto.getLatitude(), dto.getLongitude(),dto.getDescription(), state.get());
                address = repository.saveAndFlush(address);
                return address;
            }else{
                return null;
            }
        }
    }



}
