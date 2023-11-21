package mx.edu.utez.viajabara.basecatalog.seatingSales.control;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsRepository;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesDto;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesRepository;
import mx.edu.utez.viajabara.utils.entity.Message;
import mx.edu.utez.viajabara.utils.entity.TypesResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Transactional
@Service
public class SeatingSalesService {

    private final static Logger logger = LoggerFactory.getLogger(SeatingSalesService.class);

    private final SeatingSalesRepository repository;
    private final UserRepository userRepository;
    private final OpenTripsRepository openTripsRepository;

    @Autowired
    public SeatingSalesService(SeatingSalesRepository repository, UserRepository userRepository, OpenTripsRepository openTripsRepository) {
        this.repository = repository;
        this.userRepository = userRepository;
        this.openTripsRepository = openTripsRepository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        List<SeatingSales> seatingSalesList = repository.findAll();
        List<SeatingSales> response = new ArrayList<>();
        for (SeatingSales seatingSales:seatingSalesList) {
            seatingSales.getOpenTrips().getTrip().getDriver().setProfile(null);
            seatingSales.getOpenTrips().getTrip().getBus().setImage(null);
            seatingSales.getClient().setProfile(null);
            response.add(seatingSales);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllByClient(SeatingSalesDto dto) {
        Optional<User> optional = userRepository.findById(dto.getClient().getId());
        if(!optional.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró al cliente", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        List<SeatingSales> seatingSalesList = repository.findAllByClient(optional.get());
        List<SeatingSales> response = new ArrayList<>();
        for (SeatingSales seatingSales:seatingSalesList) {
            seatingSales.getOpenTrips().getTrip().getDriver().setProfile(null);
            seatingSales.getOpenTrips().getTrip().getBus().setImage(null);
            seatingSales.getClient().setProfile(null);
            response.add(seatingSales);
        }
        return new ResponseEntity<>(new Message(response, "Listado de compra de asientos por cliente", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllByOpenTrip(SeatingSalesDto dto) {
        Optional<OpenTrips> optional = openTripsRepository.findById(dto.getOpenTrips().getId());
        if(!optional.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        List<SeatingSales> seatingSalesList = repository.findAllByOpenTrips(optional.get());
        List<SeatingSales> response = new ArrayList<>();
        for (SeatingSales seatingSales:seatingSalesList) {
            seatingSales.getOpenTrips().getTrip().getDriver().setProfile(null);
            seatingSales.getOpenTrips().getTrip().getBus().setImage(null);
            seatingSales.getClient().setProfile(null);
            response.add(seatingSales);
        }
        return new ResponseEntity<>(new Message(response, "Listado de compra de asientos por viaje", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(SeatingSalesDto dto) throws SQLException {
        Optional<User> userOptional = userRepository.findById(dto.getClient().getId());
        if(!userOptional.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró al cliente", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<OpenTrips> openTripsOptional = openTripsRepository.findById(dto.getOpenTrips().getId());
        if(!openTripsOptional.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        SeatingSales seatingSales = new SeatingSales(dto.getStart_latitude(),dto.getStart_longitude(), dto.getEnd_latitude(), dto.getEnd_longitude(), dto.getCost(),userOptional.get(), dto.getSeating(), openTripsOptional.get());

        seatingSales = repository.saveAndFlush(seatingSales);

        if (seatingSales == null) {
            return new ResponseEntity<>(new Message("No se registró la venta del lugar", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(seatingSales, "Se registró la venta del lugar", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(SeatingSalesDto dto) throws SQLException {
        Optional<SeatingSales> optionalSeatingSales = repository.findById(dto.getId());
        if(!optionalSeatingSales.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<User> userOptional = userRepository.findById(dto.getClient().getId());
        if(!userOptional.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró al cliente", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<OpenTrips> openTripsOptional = openTripsRepository.findById(dto.getOpenTrips().getId());
        if(!openTripsOptional.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        SeatingSales seatingSales = optionalSeatingSales.get();

        seatingSales.setStart_latitude(dto.getStart_latitude());
        seatingSales.setStart_longitude(dto.getStart_longitude());
        seatingSales.setEnd_latitude(dto.getEnd_latitude());
        seatingSales.setEnd_longitude(dto.getEnd_longitude());
        seatingSales.setCost(dto.getCost());
        seatingSales.setSeating(dto.getSeating());
        seatingSales.setClient(userOptional.get());
        seatingSales.setOpenTrips(openTripsOptional.get());

        seatingSales = repository.saveAndFlush(seatingSales);

        if (seatingSales == null) {
            return new ResponseEntity<>(new Message("No se modificó la venta de lugar", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(seatingSales, "Se modificó la venta de lugar", TypesResponse.SUCCESS), HttpStatus.OK);
    }


}
