package mx.edu.utez.viajabara.basecatalog.openTrips.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsDto;
import mx.edu.utez.viajabara.basecatalog.trip.model.BookTripDto;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/open-trips")
@Api(tags = "Viajes Abiertos")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class OpenTripsController {

    public static final String VIAJES_ABIERTOS = "VIAJES_ABIERTOS";

    private final OpenTripsService service;

    @Autowired
    public OpenTripsController(OpenTripsService service) {
        this.service = service;
    }

    @PutMapping("/getOne")
    @Secured({VIAJES_ABIERTOS})
    @ApiOperation(
            value = "Obtiene un viaje",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> getOne(@Validated(TripDto.ChangeStatus.class) @RequestBody TripDto dto) {
        return service.getOne(dto.getId());
    }

    @PostMapping("/find-open-trip-by-trip")
    @Secured({VIAJES_ABIERTOS})
    @ApiOperation(
            value = "Obtiene un registro por trip_id y fecha",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> getOpenTripByTripIdAndStartDate( @RequestBody int tripId, String date) {
        return service.getOpenTripByTripIdAndStartDate(tripId, date);
    }

    @GetMapping("/all")
    @Secured({VIAJES_ABIERTOS})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }

    @GetMapping("/enabled")
    @Secured({VIAJES_ABIERTOS})
    public ResponseEntity<Object> findAllEnabled() throws SQLException {
        return service.findAllEnabled();
    }

    @PostMapping("")
    @Secured({VIAJES_ABIERTOS})
    @ApiOperation(
            value = "Registra una ruta",
            notes = "{\n" +
                    "  \"duty\": {\n" +
                    "    \"id\": 1\n" +
                    "  },\n" +
                    "  \"end_latitude\": \"aaaaa\",\n" +
                    "  \"end_longitude\": \"bbbbb\",\n" +
                    "  \"start_latitude\": \"ccccc\",\n" +
                    "  \"start_longitude\": \"dddddd\",\n" +
                    "  \"stopOvers\": [\n" +
                    "    {\n" +
                    "      \"latitude\": \"eeeee\",\n" +
                    "      \"longitude\": \"fffff\",\n" +
                    "      \"sequence\": 1,\n" +
                    "      \"status\": true\n" +
                    "    }\n" +
                    "  ]\n" +
                    "}"
    )
    public ResponseEntity<Object> save(@Validated(OpenTripsDto.Register.class) @RequestBody OpenTripsDto dto) throws SQLException {
        return service.save(dto);
    }

    @PutMapping("")
    @Secured({VIAJES_ABIERTOS})
    @ApiOperation(
            value = "Actualiza una ruta",
            notes = "{\n" +
                    "  \"duty\": {\n" +
                    "    \"id\": 1\n" +
                    "  },\n" +
                    "  \"end_latitude\": \"aaaaa\",\n" +
                    "  \"end_longitude\": \"bbbbb\",\n" +
                    "  \"start_latitude\": \"ccccc\",\n" +
                    "  \"start_longitude\": \"dddddd\",\n" +
                    "  \"stopOvers\": [\n" +
                    "    {\n" +
                    "      \"latitude\": \"eeeee\",\n" +
                    "      \"longitude\": \"fffff\",\n" +
                    "      \"sequence\": 1,\n" +
                    "      \"status\": true\n" +
                    "    }\n" +
                    "  ]\n" +
                    "}"
    )
    public ResponseEntity<Object> update(@Validated(OpenTripsDto.Modify.class) @RequestBody OpenTripsDto dto) throws SQLException {
        return service.update(dto);
    }

    @PutMapping("/change-status")
    @Secured({VIAJES_ABIERTOS})
    @ApiOperation(
            value = "Cambia el estado de un viaje abierto",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> changeStatus(@Validated(OpenTripsDto.ChangeStatus.class) @RequestBody OpenTripsDto dto) throws SQLException {
        return service.changeStatus(dto);
    }
}
