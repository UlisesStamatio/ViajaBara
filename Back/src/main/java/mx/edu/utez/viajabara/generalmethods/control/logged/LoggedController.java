package mx.edu.utez.viajabara.generalmethods.control.logged;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.access.user.model.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/logged")
@Api(tags = "General")
@CrossOrigin(origins = {"*"}, methods = { RequestMethod.GET,RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
public class LoggedController {

    private final LoggedService service;

    @Autowired
    public LoggedController(LoggedService service) {
        this.service = service;
    }

    @ApiOperation(
            value = "Cambiar la foto de perfil",
            notes = "{\n" +
                    "    \"id\": \1,\"\n" +
                    "    \"profile\": \"imagen base 64\"\n" +
                    "}"
    )
    @PutMapping("/change-profile")
    public ResponseEntity<Object> changeProfile(@Validated(UserDto.ChangeProfile.class) @RequestBody UserDto dto) throws SQLException {
        return service.changeProfile(dto);
    }


    @ApiOperation(
            value = "Obtiene los datos de un usuario para su perfil",
            notes = "{\n" +
                    "    \"email\": \"20203tn159@utez.edu.mx\"\n" +
                    "}"
    )
    @PutMapping("/get-user")
    public ResponseEntity<Object> getUserByEmail(@Validated(UserDto.GetUser.class) @RequestBody UserDto dto) throws SQLException {
        return service.getUserByEmail(dto);
    }

}
