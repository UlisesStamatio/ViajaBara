package mx.edu.utez.viajabara.basecatalog.paymentMethod.control;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.paymentMethod.model.PaymentMethodDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/payment-methods")
@Api(tags = "Metodos de pago")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
public class PaymentMethodController {
    public static final String METODOS_DE_PAGO = "METODOS_DE_PAGO";

    private final PaymentMethodService service;

    @Autowired
    public PaymentMethodController(PaymentMethodService service) {
        this.service = service;
    }

    @GetMapping("/all")
    @Secured({METODOS_DE_PAGO})
    public ResponseEntity<Object> findAll() throws SQLException {
        return service.findAll();
    }

    @PostMapping("")
    @Secured({METODOS_DE_PAGO})
    @ApiOperation(
            value = "Registra un metodo de pago",
            notes = "{ " +
                    "\"name\": \"Estado 2\" " +
                    "\"apikey\": \"dasdasdasdsadasdasdasdsa\" " +
                    "}"
    )
    public ResponseEntity<Object> save(@Validated(PaymentMethodDto.Register.class) @RequestBody PaymentMethodDto dto) throws SQLException {
        return service.save(dto);
    }

    @PutMapping("")
    @Secured({METODOS_DE_PAGO})
    @ApiOperation(
            value = "Actualiza el metodo de pago",
            notes = "{\n" +
                    " \"id\": 2,\n" +
                    "  \"name\": \"Estado 2\" \n" +
                    "\"apikey\": \"dasdasdasdsadasdasdasdsa\" " +
                    " }"
    )
    public ResponseEntity<Object> update(@Validated({PaymentMethodDto.Modify.class}) @RequestBody PaymentMethodDto dto) {
        return service.update(dto);
    }

    @PutMapping("/change-status")
    @Secured({METODOS_DE_PAGO})
    @ApiOperation(
            value = "Actualiza el estado del metodo de pago",
            notes = "{ \"id\": 2 }"
    )
    public ResponseEntity<Object> changeStatus(@Validated(PaymentMethodDto.ChangeStatus.class) @RequestBody PaymentMethodDto dto) {
        return service.changeStatus(dto);
    }

}
