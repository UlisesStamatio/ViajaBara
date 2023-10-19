package mx.edu.utez.viajabara.generalmethods.control;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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

    @Autowired
    public ActiveController(StateService serviceStates) {
        this.serviceStates = serviceStates;
    }

    @GetMapping("/states")
    @ApiOperation(
            value = "Obtiene todos los estados activos"
    )
    public ResponseEntity<Object> findAllEnabledStates() {
        return serviceStates.findAllEnabled();
    }

}
