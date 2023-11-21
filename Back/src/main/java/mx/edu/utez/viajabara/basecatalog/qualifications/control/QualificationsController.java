package mx.edu.utez.viajabara.basecatalog.qualifications.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.qualifications.model.QualificationsDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/qualifications")
@Api(tags = "Calificaciones")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class QualificationsController {

    public static final String CALIFICACIONES = "CALIFICACIONES";

    private final QualificationsService service;

    @Autowired
    public QualificationsController(QualificationsService service) {
        this.service = service;
    }

    @PostMapping("")
    @Secured({CALIFICACIONES})
    @ApiOperation(
            value = "Registra una calificación",
            notes = ""
    )
    public ResponseEntity<Object> save(@Validated(QualificationsDto.Register.class) @RequestBody QualificationsDto dto) throws SQLException {
        return service.save(dto);
    }

    @PutMapping("")
    @Secured({CALIFICACIONES})
    @ApiOperation(
            value = "Modifica una calificación",
            notes = ""
    )
    public ResponseEntity<Object> update(@Validated(QualificationsDto.Modify.class) @RequestBody QualificationsDto dto) throws SQLException {
        return service.update(dto);
    }
}
