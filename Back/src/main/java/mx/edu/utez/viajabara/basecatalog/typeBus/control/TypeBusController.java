package mx.edu.utez.viajabara.basecatalog.typeBus.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.duty.control.DutyService;
import mx.edu.utez.viajabara.basecatalog.duty.model.DutyDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/type-bus")
@Api(tags = "Tipos de Autobuses")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class TypeBusController {
    public static final String TIPOS_AUTOBUSES = "TIPOS_AUTOBUSES";

    private final TypeBusService service;

    @Autowired
    public TypeBusController(TypeBusService service) {
        this.service = service;
    }

    @GetMapping("/all")
    @Secured({TIPOS_AUTOBUSES})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }

    @GetMapping("/enabled")
    @Secured({TIPOS_AUTOBUSES})
    public ResponseEntity<Object> findAllEnabled() throws SQLException {
        return service.findAllEnabled();
    }

}
