package mx.edu.utez.viajabara.basecatalog.person.control;

import mx.edu.utez.viajabara.access.user.control.UserService;
import mx.edu.utez.viajabara.basecatalog.person.model.Person;
import mx.edu.utez.viajabara.basecatalog.person.model.PersonDto;
import mx.edu.utez.viajabara.basecatalog.person.model.PersonRepository;
import mx.edu.utez.viajabara.basecatalog.state.control.StateService;
import mx.edu.utez.viajabara.basecatalog.state.model.State;
import mx.edu.utez.viajabara.utils.entity.Message;
import mx.edu.utez.viajabara.utils.entity.TypesResponse;
import mx.edu.utez.viajabara.utils.validator.CurpValidator;
import mx.edu.utez.viajabara.utils.validator.PhoneValidator;
import mx.edu.utez.viajabara.utils.validator.RfcValidator;
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
public class PersonService {
    private final static Logger logger = LoggerFactory.getLogger(UserService.class);

    private final PersonRepository repository;
    private final RfcValidator rfcValidator;
    private final CurpValidator curpValidator;
    private final PhoneValidator phoneValidator;
    private final StateService stateService;

    @Autowired
    public PersonService(PersonRepository repository, RfcValidator rfcValidator, CurpValidator curpValidator, PhoneValidator phoneValidator, StateService stateService) {
        this.repository = repository;
        this.rfcValidator = rfcValidator;
        this.curpValidator = curpValidator;
        this.phoneValidator = phoneValidator;
        this.stateService = stateService;
    }

    @Transactional(readOnly = true)
    public Optional<Person> findById(Long id) {
        return repository.findById(id);
    }

    @Transactional(readOnly = true)
    public Optional<Person> findByName(String name) {
        return repository.findByName(name);
    }

    @Transactional(readOnly = true)
    public ResponseEntity findAll() {
        return new ResponseEntity<>(new Message(repository.findAll(),
                "Lista de las personas", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity findAllEnabled() {
        return new ResponseEntity<>(new Message(repository.findAllByStatus(true),
                "Lista de las personas activas", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity save(PersonDto dto) throws SQLException {
        if(dto.getSex() != null){
            dto.setSex(dto.getSex().toUpperCase());
        }

        if (dto.getCellphone() != null) {
            if (!phoneValidator.isValid(dto.getCellphone())) {
                return new ResponseEntity<>(new Message("Celular malformado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
            }
        }

        Person person = new Person();
        person.asignValuesRegister(dto);


        if(dto.getState() != null){
            Optional<State> optionalState = stateService.findById(dto.getState().getId());
            if (!optionalState.isPresent()) {
                return new ResponseEntity<>(new Message("Estado de residencia no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
            }
            if (!optionalState.get().isStatus()) {
                return new ResponseEntity<>(new Message("Estado de residencia inactivo", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
            }
            person.setState(optionalState.get());
        }

        person.setStatus(true);
        person = repository.saveAndFlush(person);
        if (person == null) {
            return new ResponseEntity<>(new Message("Persona no registrada", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(person, "Persona registrada", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity update(PersonDto dto) throws SQLException {
        Optional<Person> optionalPerson = repository.findById(dto.getId());
        if (!optionalPerson.isPresent()) {
            return new ResponseEntity<>(new Message("Persona no encontrada", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        if(dto.getSex() != null){
            dto.setSex(dto.getSex().toUpperCase());
        }


        Person person = optionalPerson.get();

        if (dto.getCellphone() != null) {
            if (!phoneValidator.isValid(dto.getCellphone())) {
                return new ResponseEntity<>(new Message("Celular malformado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
            }
        }
        Optional<State> optionalState = stateService.findById(dto.getState().getId());
        if (!optionalState.isPresent()) {
            return new ResponseEntity<>(new Message("Estado de residencia no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        if (!optionalState.get().isStatus()) {
            return new ResponseEntity<>(new Message("Estado de residencia inactivo", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        person.asignValuesModify(dto);
        person.setState(optionalState.get());
        person = repository.saveAndFlush(person);
        if (person == null) {
            return new ResponseEntity<>(new Message("Persona no modificada", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(person, "Persona modificada", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity changeStatus(PersonDto dto) throws SQLException {
        Optional<Person> optionalPerson = repository.findById(dto.getId());
        if (!optionalPerson.isPresent()) {
            return new ResponseEntity<>(new Message("Persona no encontrada", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Person person = optionalPerson.get();
        boolean status = person.isStatus();
        person.setStatus(!status);
        person = repository.saveAndFlush(person);
        if (person == null) {
            return new ResponseEntity<>(new Message("Estado de la persona no modificado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(person, "Estado de la persona modificado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public Person saveInitialPerson(Person person) {
        return repository.saveAndFlush(person);
    }
}