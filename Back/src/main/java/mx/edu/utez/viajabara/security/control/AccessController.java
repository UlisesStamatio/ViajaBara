package mx.edu.utez.viajabara.security.control;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.access.user.control.UserService;
import mx.edu.utez.viajabara.access.user.model.UserDto;
import mx.edu.utez.viajabara.access.visualconfig.control.VisualConfigService;
import mx.edu.utez.viajabara.security.dto.JwtDto;
import mx.edu.utez.viajabara.security.dto.LoginDto;
import mx.edu.utez.viajabara.security.service.AccessService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;

@RestController
@RequestMapping("/api/auth")
@Api(tags = "Acceso")
@CrossOrigin(origins = {"*"}, methods = {RequestMethod.POST, RequestMethod.GET})
public class AccessController {

    private final static Logger logger = LoggerFactory.getLogger(AccessController.class);

    private final AccessService accessService;
    private final UserService userService;
    private final VisualConfigService visualConfigService;


    @Autowired
    public AccessController(AccessService accessService, UserService userService, VisualConfigService visualConfigService) {
        this.accessService = accessService;
        this.userService = userService;
        this.visualConfigService = visualConfigService;
    }

    @ApiOperation(
            value = "Inicio de sesión",
            notes = "{\n" +
                    "    \"email\": \"admin@localhost.com\",\n" +
                    "    \"password\": \"Admin123\"\n" +
                    "}"
    )
    @PostMapping("/login")
    public ResponseEntity<JwtDto> login(@RequestBody LoginDto loginDto) throws Exception {
        return accessService.login(loginDto);
    }

    @PostMapping("/register")
    @ApiOperation(
            value = "Registra un usuario",
            notes = "\n" +
                    "{\n" +
                    "\"profile\":\"aa\",\n" +
                    "\"username\": \"juanperez\",\n" +
                    "\"email\": \"admin@gmail.com\",\n" +
                    "\"person\": {\n" +
                    "\"name\": \"Juan\",\n" +
                    "\"surname\": \"Pérez Herrera\",\n" +
                    "\"cellphone\": \"7773792873\",\n" +
                    "\"birthDate\": \"2000-02-02\",\n" +
                    "\"sex\": \"h\",\n" +
                    "\"state\": { \"id\": 1 }\n" +
                    "},\n" +
                    "\"roles\": [ { \"id\": 2 } ]\n" +
                    "}\n"
    )
    public ResponseEntity<Object> save(@Validated({UserDto.Register.class}) @RequestBody UserDto dto) throws SQLException {
        return userService.saveClient(dto);
    }


    @ApiOperation(
            value = "Envía correo para recuperación de contraseña",
            notes = "{\n" +
                    "    \"email\": \"admin@localhost.com\",\n" +
                    "}"
    )
    @PostMapping("/recover")
    public ResponseEntity<Object> recover(@Validated({UserDto.Recover.class}) @RequestBody UserDto dto){
        return userService.recover(dto);
    }

    @ApiOperation(
            value = "Valida que el código ingresado sea correcto",
            notes = "{\n" +
                    "    \"email\": \"admin@localhost.com\",\n" +
                    "    \"recuperation\": \"winjM\"\n" +
                    "}"
    )
    @PostMapping("/verify-code")
    public ResponseEntity<Object> verifyCode(@Validated({UserDto.VerifyCode.class}) @RequestBody UserDto dto){
        return userService.verifyCode(dto);
    }

    @ApiOperation(
            value = "Envía la contraseña junto con el correo del usuario y su código",
            notes = "{\n" +
                    "    \"email\": \"20203tn159@utez.edu.mx\",\n" +
                    "    \"recuperation\": \"winjM\",\n" +
                    "    \"password\": \"Admin1234#\"\n" +
                    "}"
    )
    @PostMapping("/change-password")
    public ResponseEntity<Object> changePasword(@Validated({UserDto.ChangePassword.class}) @RequestBody UserDto dto){
        return userService.updatePassword(dto);
    }

    @GetMapping("/getVisual")
    @ApiOperation(
            value = "Obtiene las configuraciones visuales registradas"
    )
    public ResponseEntity<Object> findAll() {
        return visualConfigService.findAll();
    }
}
