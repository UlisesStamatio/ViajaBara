package mx.edu.utez.viajabara.basecatalog.trip.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.trip.model.BookTripDto;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import java.sql.SQLException;
import java.text.ParseException;

@RestController
@RequestMapping("/api/trips")
@Api(tags = "Viajes")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class TripController {

    public static final String VIAJES = "VIAJES";

    private final TripService service;

    @Autowired
    public TripController(TripService service) {
        this.service = service;
    }

    @PutMapping("/getOne")
    @Secured({VIAJES})
    @ApiOperation(
            value = "Obtiene un viaje",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> getOne(@Validated(TripDto.ChangeStatus.class) @RequestBody TripDto dto) {
        return service.getOne(dto.getId());
    }

    @GetMapping("/all")
    @Secured({VIAJES})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }

    @GetMapping("/enabled")
    @Secured({VIAJES})
    public ResponseEntity<Object> findAllEnabled() throws SQLException {
        return service.findAllEnabled();
    }

    @PostMapping("/states-for-filters-by-date")
    @Secured({VIAJES})
    @ApiOperation(
            value = "Busca los estados y direcciones disponibles en una fecha estimada",
            notes = "{ \"date\":\"2023-12-10\" }"
    )
    public ResponseEntity<Object> getStatesForFiltersByDate(@RequestBody String date) throws ParseException {
        return service.getStatesForFiltersByDate(date, true);
    }


    @PostMapping("/find-by-filters-client")
    @Secured({VIAJES})
    @ApiOperation(
            value = "Busca los viajes en base a los filtros",
            notes = "{ \"date\": 2 }"
    )
    public ResponseEntity<Object> findByFiltersClient(@RequestBody BookTripDto bookTripDto) throws ParseException {
        return service.findByFiltersClient(bookTripDto);
    }


    @PostMapping("")
    @Secured({VIAJES})
    @ApiOperation(
            value = "Registra un viaje",
            notes = "{\n" +
                    "    \"driver\":{\n" +
                    "        \"id\":1\n" +
                    "    },\n" +
                    "    \"bus\":{\n" +
                    "        \"id\":1\n" +
                    "    },\n" +
                    "    \"route\":{\n" +
                    "        \"id\":1\n" +
                    "    }\n" +
                    "}"
    )
    public ResponseEntity<Object> save(@Validated(TripDto.Register.class) @RequestBody TripDto dto) throws SQLException {
        return service.save(dto);
    }

    @PutMapping("")
    @Secured({VIAJES})
    @ApiOperation(
            value = "Actualiza un viaje",
            notes = "{\n" +
                    "id\":1\n" +
                    "    \"driver\":{\n" +
                    "        \"id\":1\n" +
                    "    },\n" +
                    "    \"bus\":{\n" +
                    "        \"id\":1\n" +
                    "    },\n" +
                    "    \"route\":{\n" +
                    "        \"id\":1\n" +
                    "    }\n" +
                    "}"
    )
    public ResponseEntity<Object> update(@Validated(TripDto.Modify.class) @RequestBody TripDto dto) throws SQLException {
        return service.update(dto);
    }

    @PutMapping("/change-status")
    @Secured({VIAJES})
    @ApiOperation(
            value = "Cambia el estado de un viaje",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> changeStatus(@Validated(TripDto.ChangeStatus.class) @RequestBody TripDto dto) {
        return service.changeStatus(dto);
    }
}
