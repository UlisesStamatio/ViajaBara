package mx.edu.utez.viajabara.basecatalog.bus.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/buses")
@Api(tags = "Autobuses")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class BusController {
    public static final String AUTOBUSES = "AUTOBUSES";

    private final BusService service;

    @Autowired
    public BusController(BusService service) {
        this.service = service;
    }

    @GetMapping("/all")
    @Secured({AUTOBUSES})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }

    @PostMapping("")
    @Secured({AUTOBUSES})
    @ApiOperation(
            value = "Registra un autobús",
            notes = "{\n" +
                    "  \"fuel\": \"Diesel\",\n" +
                    "  \"image\": \"fdsfsdfsdf\",\n" +
                    "  \"mark\": \"Mercedes\",\n" +
                    "  \"model\": \"b20\",\n" +
                    "  \"plaque\": \"SAF3321\",\n" +
                    "  \"serial\": \"DSADASDASD\"\n" +
                    "}"
    )
    public ResponseEntity<Object> save(@Validated(BusDto.Register.class) @RequestBody BusDto dto) throws SQLException {
        return service.save(dto);
    }

    @PutMapping("")
    @Secured({AUTOBUSES})
    @ApiOperation(
            value = "Actualiza el autobús",
            notes = "{\n" +
                    " \"id\": 2,\n" +
                    "  \"name\": \"Estado 2\" \n" +
                    "\"apikey\": \"dasdasdasdsadasdasdasdsa\" " +
                    " }"
    )
    public ResponseEntity<Object> update(@Validated({BusDto.Modify.class}) @RequestBody BusDto dto) throws SQLException {
        return service.update(dto);
    }

    @PutMapping("/change-status")
    @Secured({AUTOBUSES})
    @ApiOperation(
            value = "Actualiza el estado del autobús",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> changeStatus(@Validated(BusDto.ChangeStatus.class) @RequestBody BusDto dto) {
        return service.changeStatus(dto);
    }

    @PutMapping("/getOne")
    @Secured({AUTOBUSES})
    @ApiOperation(
            value = "Obtiene un autobus",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> getOne(@Validated(BusDto.ChangeStatus.class) @RequestBody BusDto dto) {
        return service.getOne(dto.getId());
    }

}
