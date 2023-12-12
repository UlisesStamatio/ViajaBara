package mx.edu.utez.viajabara.generalmethods.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.seatingSales.control.SeatingSalesService;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/client")
@Api(tags = "Cliente")
@CrossOrigin(origins = {"*"}, methods = { RequestMethod.GET,RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
public class ClientController {

    private final SeatingSalesService service;

    @Autowired
    public ClientController(SeatingSalesService service) {
        this.service = service;
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
