package mx.edu.utez.viajabara.basecatalog.duty.control;

import mx.edu.utez.viajabara.basecatalog.duty.model.Duty;
import mx.edu.utez.viajabara.basecatalog.duty.model.DutyDto;
import mx.edu.utez.viajabara.basecatalog.duty.model.DutyRepository;
import mx.edu.utez.viajabara.basecatalog.state.model.State;
import mx.edu.utez.viajabara.utils.entity.Message;
import mx.edu.utez.viajabara.utils.entity.TypesResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.Optional;

@Transactional
@Service
public class DutyService {

    private final DutyRepository repository;

    @Autowired
    public DutyService(DutyRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        return new ResponseEntity<>(new Message(repository.findAll(), "Listado de servicios", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled() {
        return new ResponseEntity<>(new Message(repository.findAllByStatusIsTrue(), "Listado de servicios activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public Optional<Duty> findById(Long id) {
        return repository.findById(id);
    }


    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(DutyDto dto) throws SQLException {
        Optional<Duty> optional = repository.searchByNameAndId(dto.getName(), 0L);
        if (optional.isPresent()) {
            return new ResponseEntity<>(new Message("El nombre del servicio ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        Duty duty = new Duty(dto.getName(), true);
        duty = repository.saveAndFlush(duty);
        if (duty == null) {
            return new ResponseEntity<>(new Message("No se registró el servicio", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(duty, "Se registró el servicio", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(DutyDto dto) {
        Optional<Duty> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el Servicio", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<Duty> optionalDuty = repository.searchByNameAndId(dto.getName(), dto.getId());
        if (optionalDuty.isPresent()) {
            return new ResponseEntity<>(new Message("El nombre del servicio ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        Duty duty = optional.get();
        duty.setName(dto.getName());
        duty = repository.saveAndFlush(duty);
        if (duty == null) {
            return new ResponseEntity<>(new Message("No se modificó el servicio", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(duty, "Se modificó el servicio", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeStatus(DutyDto dto) {
        Optional<Duty> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el servicio", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Duty duty = optional.get();
        duty.setStatus(!duty.isStatus());
        duty = repository.saveAndFlush(duty);
        if (duty == null) {
            return new ResponseEntity<>(new Message("No se modificó el servicio", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(duty, "Se modificó el servicio", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public Optional<Duty> findByName(String name) {
        return repository.findFirstByName(name);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public Duty saveInitialDuty(Duty duty) {
        return repository.saveAndFlush(duty);
    }

}
