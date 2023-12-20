package mx.edu.utez.viajabara.generalmethods.control.logged;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import mx.edu.utez.viajabara.access.user.model.UserDto;
import mx.edu.utez.viajabara.basecatalog.openTrips.control.OpenTripsService;
import mx.edu.utez.viajabara.basecatalog.qualifications.control.QualificationsService;
import mx.edu.utez.viajabara.basecatalog.seatingSales.control.SeatingSalesService;
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
    private final OpenTripsService openTripsService;
    private final SeatingSalesService seatingSalesService;
    private final QualificationsService qualificationsService;

    @Autowired
    public LoggedController(LoggedService service, OpenTripsService openTripsService, SeatingSalesService seatingSalesService, QualificationsService qualificationsService) {
        this.service = service;
        this.openTripsService = openTripsService;
        this.seatingSalesService = seatingSalesService;
        this.qualificationsService = qualificationsService;
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

    @ApiOperation(
            value = "Actualiza los datos del perfil de usuario",
            notes = "{\n" +
                    "    \"id\": 1,\n" +
                    "    \"person\": {\n" +
                    "        \"id\": 1,\n" +
                    "        \"name\": \"Luis\",\n" +
                    "        \"surname\": \"López\",\n" +
                    "        \"cellphone\": \"0000001111\",\n" +
                    "        \"sex\": \"M\",\n" +
                    "        \"birthDate\": \"1990-05-12\",\n" +
                    "        \"state\": {\n" +
                    "            \"id\":1\n" +
                    "        },\n" +
                    "        \"status\": true\n" +
                    "    },\n" +
                    "    \"status\": true\n" +
                    "}"
    )
    @PutMapping("/update-user")
    public ResponseEntity<Object> updateUserDetails(@Validated(UserDto.ChangeDetailsProfile.class) @RequestBody UserDto dto) throws SQLException {
        return service.updateUserDetails(dto);
    }

    @ApiOperation(
            value = "Obtener la cantidad de viajes realizados por un conductor en particular",
            notes = "{\n" +
                    "    \"id\": \1,\"\n" +
                    "}"
    )
    @PutMapping("/driver-trips-count")
    public ResponseEntity<Object> countTripsByDriver(@Validated(UserDto.ChangeStatus.class) @RequestBody UserDto dto) throws SQLException {
        return openTripsService.countTripsByDriver(dto.getId());
    }

    @ApiOperation(
            value = "Obtener la cantidad de viajes realizados por un cliente en particular",
            notes = "{\n" +
                    "    \"id\": \1,\"\n" +
                    "}"
    )
    @PutMapping("/client-trips-count")
    public ResponseEntity<Object> countTripsByClient(@Validated(UserDto.ChangeStatus.class) @RequestBody UserDto dto) throws SQLException {
        return seatingSalesService.countTripsByClient(dto.getId());
    }

    @ApiOperation(
            value = "Obtener la calificación promedio de un conductor en particular",
            notes = "{\n" +
                    "    \"id\": \1,\"\n" +
                    "}"
    )
    @PutMapping("/driver-qualification-average")
    public ResponseEntity<Object> generalQualificationByDriver(@Validated(UserDto.ChangeStatus.class) @RequestBody UserDto dto) throws SQLException {
        return qualificationsService.generalQualificationByDriver(dto.getId());
    }

}
