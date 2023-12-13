package mx.edu.utez.viajabara.generalmethods.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.qualifications.control.QualificationsService;
import mx.edu.utez.viajabara.basecatalog.qualifications.model.QualificationsDto;
import mx.edu.utez.viajabara.basecatalog.seatingSales.control.SeatingSalesService;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/client")
@Api(tags = "Cliente")
@CrossOrigin(origins = {"*"}, methods = { RequestMethod.GET,RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
public class ClientController {

    private final SeatingSalesService service;
    private final QualificationsService qualificationsService;

    @Autowired
    public ClientController(SeatingSalesService service, QualificationsService qualificationsService) {
        this.service = service;
        this.qualificationsService = qualificationsService;
    }


    @PostMapping("/register-qualification")
    @ApiOperation(
            value = "Registra una calificación",
            notes = "{\n" +
                    "    \"seatingSales\": {\n" +
                    "        \"id\": 1\n" +
                    "    },\n" +
                    "    \"comments\":\"Esto es un ejemplo\",\n" +
                    "    \"score\":4\n" +
                    "}"
    )
    public ResponseEntity<Object> save(@Validated(QualificationsDto.Register.class) @RequestBody QualificationsDto dto) throws SQLException {
        return qualificationsService.save(dto);
    }


    @PutMapping("/all-by-client")
    @ApiOperation(
            value = "Obtiene todas las ventas de asientos por un usuario",
            notes = "{\n" +
                    "    \"client\": {\n" +
                    "        \"id\": 1\n" +
                    "    }\n" +
                    "}"
    )
    public ResponseEntity<Object> findAllByClient(@Validated(SeatingSalesDto.FindByClient.class) @RequestBody SeatingSalesDto dto) {
        return service.findAllByClient(dto);
    }
}
