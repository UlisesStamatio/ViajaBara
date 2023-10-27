package mx.edu.utez.viajabara.generalmethods.control;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.access.user.model.UserDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import java.sql.SQLException;

@RestController
@RequestMapping("/api/general")
@Api(tags = "General")
@CrossOrigin(origins = {"*"}, methods = { RequestMethod.GET,RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
public class GeneralController {

    private final GeneralService service;

    @Autowired
    public GeneralController(GeneralService service) {
        this.service = service;
    }

    private final static Logger logger = LoggerFactory.getLogger(GeneralController.class);



    @ApiOperation(
            value = "Cambio de contraseña del usuario",
            notes = "\"email\": \"String\",\n" +
                    "    \"password\": \"String\",\n" +
                    "    \"passwordNew\": \"String\""
    )
    @PutMapping("/change-password")
    public ResponseEntity<Object> changePassword(@Validated(UserDto.UpdatePassword.class) @RequestBody UserDto dto) throws SQLException {
        return service.changePassword(dto);
    }


    @ApiOperation(
            value = "Cambio de foto de perfil",
            notes = "{\n" +
                    "    \"id\": \1,\"\n" +
                    "    \"profile\": \"imagen base 64\"\n" +
                    "}"
    )
    @PutMapping("/change-password")
    public ResponseEntity<Object> changeProfile(@Validated(UserDto.ChangeProfile.class) @RequestBody UserDto dto) throws SQLException {
        return service.changeProfile(dto);
    }

}
