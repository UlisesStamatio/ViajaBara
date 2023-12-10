package mx.edu.utez.viajabara.generalmethods.control.logged;


import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserDto;
import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.person.control.PersonService;
import mx.edu.utez.viajabara.basecatalog.person.model.PersonDto;
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
public class LoggedService {
    private final static Logger logger = LoggerFactory.getLogger(LoggedService.class);

    private final UserRepository repository;
    private final PersonService personService;


    @Autowired
    public LoggedService(UserRepository repository, PersonService personService) {
        this.repository = repository;
        this.personService = personService;
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeProfile(UserDto dto) {
        Optional<User> optionalUser = repository.findById(dto.getId());
        if (!optionalUser.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el usuario", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        User user = optionalUser.get();
        user.setProfile(dto.getProfile());
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("No se modificó la foto de perfil", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Foto de perfil modificada", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> getUserByEmail(UserDto dto) {
        Optional<User> optionalUser = repository.findFirstByEmail(dto.getEmail());
        if (!optionalUser.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el usuario", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        User user = optionalUser.get();
        return new ResponseEntity<>(new Message(user, "Usuario encontrado", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> updateUserDetails(UserDto dto) throws SQLException {
        Optional<User> optionalUser = repository.findById(dto.getId());
        if (!optionalUser.isPresent()) {
            return new ResponseEntity<>(new Message("Usuario no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        User user = optionalUser.get();
        dto.getPerson().setId(user.getPerson().getId());
        PersonDto personDto = new PersonDto(dto.getPerson());
        ResponseEntity responseEntity = personService.update(personDto);
        Message message = (Message) responseEntity.getBody();
        assert message != null;
        if (!message.getType().equals(TypesResponse.SUCCESS)) {
            return new ResponseEntity<>(new Message(message.getText(), message.getType()), HttpStatus.BAD_REQUEST);
        }
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("Usuario no modificado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Usuario modificado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

}
