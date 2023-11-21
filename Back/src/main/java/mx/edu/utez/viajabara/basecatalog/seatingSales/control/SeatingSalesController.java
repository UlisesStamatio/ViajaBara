package mx.edu.utez.viajabara.basecatalog.seatingSales.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/seating-sales")
@Api(tags = "Ventas de Asientos")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class SeatingSalesController {
    public static final String VENTA_ASIENTOS = "VENTA_ASIENTOS";

    private final SeatingSalesService service;

    @Autowired
    public SeatingSalesController(SeatingSalesService service) {
        this.service = service;
    }

    @GetMapping("/all")
    @Secured({VENTA_ASIENTOS})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }

    @PutMapping("/all-by-client")
    @Secured({VENTA_ASIENTOS})
    @ApiOperation(
            value = "Obtiene todas las ventas de asientos por un usuario",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> findAllByClient(@Validated(SeatingSalesDto.FindByClient.class) @RequestBody SeatingSalesDto dto) {
        return service.findAllByClient(dto);
    }

    @PutMapping("/all-by-open-trip")
    @Secured({VENTA_ASIENTOS})
    @ApiOperation(
            value = "Obtiene todas las ventas de asientos ",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> findAllByOpenTrip(@Validated(SeatingSalesDto.FindByOpenTrip.class) @RequestBody SeatingSalesDto dto) {
        return service.findAllByOpenTrip(dto);
    }

    @PostMapping("")
    @Secured({VENTA_ASIENTOS})
    @ApiOperation(
            value = "Registra una venta de asiento",
            notes = "{\n" +
                    "    \"cost\":200,\n" +
                    "    \"client\":{\n" +
                    "        \"id\":1\n" +
                    "    },\n" +
                    "    \"openTrips\":{\n" +
                    "        \"id\":1\n" +
                    "    },\n" +
                    "    \"seating\":12,\n" +
                    "    \"start_latitude\":\"string\",\n" +
                    "    \"start_longitude\":\"string\",\n" +
                    "    \"end_latitude\":\"string\",\n" +
                    "    \"end_longitude\":\"string\"\n" +
                    "}"
    )
    public ResponseEntity<Object> save(@Validated(SeatingSalesDto.Register.class) @RequestBody SeatingSalesDto dto) throws SQLException {
        return service.save(dto);
    }


    @PutMapping("")
    @Secured({VENTA_ASIENTOS})
    @ApiOperation(
            value = "Modifica una venta de asiento",
            notes = "{\n" +
                    "    \"id\":1,\n" +
                    "    \"cost\":200,\n" +
                    "    \"client\":{\n" +
                    "        \"id\":1\n" +
                    "    },\n" +
                    "    \"openTrips\":{\n" +
                    "        \"id\":1\n" +
                    "    },\n" +
                    "    \"seating\":12,\n" +
                    "    \"start_latitude\":\"string\",\n" +
                    "    \"start_longitude\":\"string\",\n" +
                    "    \"end_latitude\":\"string\",\n" +
                    "    \"end_longitude\":\"string\"\n" +
                    "}"
    )
    public ResponseEntity<Object> update(@Validated(SeatingSalesDto.Modify.class) @RequestBody SeatingSalesDto dto) throws SQLException {
        return service.update(dto);
    }
}
