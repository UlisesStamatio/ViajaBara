package mx.edu.utez.viajabara.generalmethods.control;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.basecatalog.duty.control.DutyService;
import mx.edu.utez.viajabara.basecatalog.paymentMethod.control.PaymentMethodService;
import mx.edu.utez.viajabara.basecatalog.state.control.StateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/lists")
@Api(tags = "Listados Activos")
@CrossOrigin(origins = {"*"}, methods = { RequestMethod.GET,RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
public class ActiveController {
    private final StateService serviceStates;
    private final DutyService serviceDuty;
    private final PaymentMethodService servicePayment;

    @Autowired
    public ActiveController(StateService serviceStates, DutyService serviceDuty, PaymentMethodService servicePayment) {
        this.serviceStates = serviceStates;
        this.serviceDuty = serviceDuty;
        this.servicePayment = servicePayment;
    }

    @GetMapping("/states")
    @ApiOperation(
            value = "Obtiene todos los estados activos"
    )
    public ResponseEntity<Object> findAllEnabledStates() {
        return serviceStates.findAllEnabled();
    }

    @GetMapping("/duties")
    @ApiOperation(
            value = "Obtiene todos los servicios activos"
    )
    public ResponseEntity<Object> findAllEnabledDuties() {
        return serviceDuty.findAllEnabled();
    }

    @GetMapping("/payment-methods")
    @ApiOperation(
            value = "Obtiene todos los métodos de pago activos"
    )
    public ResponseEntity<Object> findAllEnabledPayments() {
        return servicePayment.findAllEnabled();
    }

}
