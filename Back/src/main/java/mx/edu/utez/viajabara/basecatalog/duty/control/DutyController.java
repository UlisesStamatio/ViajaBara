package mx.edu.utez.viajabara.basecatalog.duty.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.duty.model.DutyDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/duties")
@Api(tags = "Estados de residencia")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class DutyController {
    public static final String DUTIES = "SERVICIOS";

    //todo agregar en el initial database los servicios principales y el privilegio de servicios para el admin

    private final DutyService service;

    @Autowired
    public DutyController(DutyService service) {
        this.service = service;
    }

    @GetMapping("/all")
    @Secured({DUTIES})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }

    @PostMapping("")
    @Secured({DUTIES})
    @ApiOperation(
            value = "Registra un servicio",
            notes = "{ \"name\": \"Estado 2\" }"
    )
    public ResponseEntity<Object> save(@Validated(DutyDto.Register.class) @RequestBody DutyDto dto) throws SQLException {
        return service.save(dto);
    }

    @PutMapping("")
    @Secured({DUTIES})
    @ApiOperation(
            value = "Actualiza el servicio",
            notes = "{\n" +
                    " \"id\": 2,\n" +
                    "  \"name\": \"Estado 2\" \n" +
                    " }"
    )
    public ResponseEntity<Object> update(@Validated({DutyDto.Modify.class}) @RequestBody DutyDto dto) {
        return service.update(dto);
    }

    @PutMapping("/change-status")
    @Secured({DUTIES})
    @ApiOperation(
            value = "Actualiza el estado del servicio",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> changeStatus(@Validated(DutyDto.ChangeStatus.class) @RequestBody DutyDto dto) {
        return service.changeStatus(dto);
    }
}
