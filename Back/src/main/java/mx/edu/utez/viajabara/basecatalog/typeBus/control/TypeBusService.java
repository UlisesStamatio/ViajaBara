package mx.edu.utez.viajabara.basecatalog.typeBus.control;

import mx.edu.utez.viajabara.basecatalog.duty.model.Duty;
import mx.edu.utez.viajabara.basecatalog.duty.model.DutyDto;
import mx.edu.utez.viajabara.basecatalog.duty.model.DutyRepository;
import mx.edu.utez.viajabara.basecatalog.typeBus.model.TypeBus;
import mx.edu.utez.viajabara.basecatalog.typeBus.model.TypeBusRepository;
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
public class TypeBusService {
    private final TypeBusRepository repository;

    @Autowired
    public TypeBusService(TypeBusRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        return new ResponseEntity<>(new Message(repository.findAll(), "Listado de tipos de unidades", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled() {
        return new ResponseEntity<>(new Message(repository.findAllByStatusIsTrue(), "Listado de tipos de unidades activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public Optional<TypeBus> findById(Long id) {
        return repository.findById(id);
    }


    @Transactional(readOnly = true)
    public Optional<TypeBus> findByDescription(String description) {
        return repository.findByDescription(description);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public TypeBus saveInitialTypeBus(TypeBus typeBus) {
        return repository.saveAndFlush(typeBus);
    }
}
