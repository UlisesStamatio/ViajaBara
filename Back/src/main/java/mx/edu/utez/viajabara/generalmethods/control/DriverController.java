package mx.edu.utez.viajabara.generalmethods.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.openTrips.control.OpenTripsService;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/driver")
@Api(tags = "Conductor")
@CrossOrigin(origins = {"*"}, methods = { RequestMethod.GET,RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
public class DriverController {

    private final OpenTripsService openTripsService;

    @Autowired
    public DriverController(OpenTripsService openTripsService) {
        this.openTripsService = openTripsService;
    }

    @PutMapping("/findAllToday")
    @ApiOperation(
            value = "Obtiene todos los viajes de hoy",
            notes = "{\n" +
                    "    \"driver\":{\n" +
                    "        \"id\":1\n" +
                    "    }\n" +
                    "}"
    )
    public ResponseEntity<Object> findAllToday(@Validated(TripDto.FindByDriver.class) @RequestBody TripDto dto) {
        return openTripsService.findAllTripsToday(dto.getDriver().getId());
    }

    @PutMapping("/getOne")
    @ApiOperation(
            value = "Obtiene un viaje abierto",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> getOne(@Validated(TripDto.ChangeStatus.class) @RequestBody TripDto dto) {
        return openTripsService.getOne(dto.getId());
    }
}
