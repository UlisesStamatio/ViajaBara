package mx.edu.utez.viajabara.basecatalog.state.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.state.model.StateDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/state")
@Api(tags = "Estados de residencia")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class StateController {
    public static final String STATES = "ESTADOS";

    private final StateService service;

    @Autowired
    public StateController(StateService service) {
        this.service = service;
    }

    @GetMapping("/all")
    @Secured({STATES})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }


    @PostMapping("")
    @Secured({STATES})
    @ApiOperation(
            value = "Registra un estado",
            notes = "{ \"name\": \"Estado 2\" }"
    )
    public ResponseEntity<Object> save(@Validated(StateDto.Register.class) @RequestBody StateDto dto) {
        return service.save(dto);
    }

    @PutMapping("")
    @Secured({STATES})
    @ApiOperation(
            value = "Actualiza el estado de residencia",
            notes = "{\n" +
                    " \"id\": 2,\n" +
                    "  \"name\": \"Estado 2\" \n" +
                    " }"
    )
    public ResponseEntity<Object> update(@Validated({StateDto.Modify.class}) @RequestBody StateDto dto) {
        return service.update(dto);
    }

    @PutMapping("/change-status")
    @Secured({STATES})
    @ApiOperation(
            value = "Actualiza el estado del estado de residencia",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> changeStatus(@Validated(StateDto.ChangeStatus.class) @RequestBody StateDto dto) {
        return service.changeStatus(dto);
    }
}
