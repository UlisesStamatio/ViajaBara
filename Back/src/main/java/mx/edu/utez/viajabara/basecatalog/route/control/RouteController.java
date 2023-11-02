package mx.edu.utez.viajabara.basecatalog.route.control;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusDto;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/routes")
@Api(tags = "Rutas")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class RouteController {
    public static final String RUTAS = "RUTAS";

    private final RouteService service;

    @Autowired
    public RouteController(RouteService service) {
        this.service = service;
    }

    @GetMapping("/all")
    @Secured({RUTAS})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }

    @GetMapping("/enabled")
    @Secured({RUTAS})
    public ResponseEntity<Object> findAllEnabled() throws SQLException {
        return service.findAllEnabled();
    }

    @PostMapping("")
    @Secured({RUTAS})
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
    public ResponseEntity<Object> save(@Validated(RouteDto.Register.class) @RequestBody RouteDto dto) throws SQLException {
        return service.save(dto);
    }

    @PutMapping("/getOne")
    @Secured({RUTAS})
    @ApiOperation(
            value = "Obtiene una ruta",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> getOne(@Validated(RouteDto.ChangeStatus.class) @RequestBody RouteDto dto) {
        return service.getOne(dto.getId());
    }
}
