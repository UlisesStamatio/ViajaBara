package mx.edu.utez.viajabara.basecatalog.seatingSales.control;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsRepository;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesDto;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesRepository;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOver;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOverRepository;
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
    private final StopOverRepository stopOverRepository;

    @Autowired
    public SeatingSalesService(SeatingSalesRepository repository, UserRepository userRepository, OpenTripsRepository openTripsRepository, StopOverRepository stopOverRepository) {
        this.repository = repository;
        this.userRepository = userRepository;
        this.openTripsRepository = openTripsRepository;
        this.stopOverRepository = stopOverRepository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        List<SeatingSales> seatingSalesList = repository.findAll();
        List<SeatingSales> response = new ArrayList<>();
        for (SeatingSales seatingSales : seatingSalesList) {
            seatingSales.getOpenTrips().getSchedule().getTrip().getDriver().setProfile(null);
            seatingSales.getOpenTrips().getSchedule().getTrip().getBus().setImage(null);
            seatingSales.getClient().setProfile(null);
            response.add(seatingSales);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllByClient(SeatingSalesDto dto) {
        Optional<User> optional = userRepository.findById(dto.getClient().getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró al cliente", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        List<SeatingSales> seatingSalesList = repository.findAllByClient(optional.get());
        List<SeatingSales> response = new ArrayList<>();
        for (SeatingSales seatingSales : seatingSalesList) {
            //seatingSales.getOpenTrips().getTrip().getDriver().setProfile(null);
            seatingSales.getOpenTrips().getSchedule().getTrip().getBus().setImage(null);
            seatingSales.getClient().setProfile(null);
            response.add(seatingSales);
        }
        return new ResponseEntity<>(new Message(response, "Listado de compra de asientos por cliente", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllByOpenTrip(SeatingSalesDto dto) {
        List<List<SeatingSales>> seatingSalesLists = new ArrayList<>();

        Optional<OpenTrips> optional = openTripsRepository.findById(dto.getOpenTrips().getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<StopOver> optionalStopOver = stopOverRepository.findById(dto.getIdStopOver());
        if (!optionalStopOver.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró la parada", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        List<SeatingSales> seatingSalesList = repository.searchAllOutByStopOverAnAndOpenTrips(optionalStopOver.get().getId(),optional.get().getId());
        List<SeatingSales> seatingSalesOut = new ArrayList<>();
        for (SeatingSales seatingSales : seatingSalesList) {
            seatingSales.getOpenTrips().getSchedule().getTrip().setDriver(null);
            seatingSales.getOpenTrips().getSchedule().getTrip().setBus(null);
            seatingSalesOut.add(seatingSales);
        }
        seatingSalesLists.add(seatingSalesOut);

        List<SeatingSales> seatingSalesList1 = repository.searchAllOnByStopOverAnAndOpenTrips(optionalStopOver.get().getId(),optional.get().getId());
        List<SeatingSales> seatingSalesOn = new ArrayList<>();
        for (SeatingSales seatingSales : seatingSalesList1) {
            seatingSales.getOpenTrips().getSchedule().getTrip().setDriver(null);
            seatingSales.getOpenTrips().getSchedule().getTrip().setBus(null);
            seatingSalesOn.add(seatingSales);
        }
        seatingSalesLists.add(seatingSalesOn);

        return new ResponseEntity<>(new Message(seatingSalesLists, "Listado de compra de asientos por viaje", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(SeatingSalesDto dto) throws SQLException {
        Optional<User> userOptional = userRepository.findById(dto.getClient().getId());
        if (!userOptional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró al cliente", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<OpenTrips> openTripsOptional = openTripsRepository.findById(dto.getOpenTrips().getId());
        if (!openTripsOptional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        SeatingSales seatingSales = new SeatingSales(new Address(dto.getStartAddress().getId()), new Address(dto.getEndAddress().getId()), dto.getCost(), userOptional.get(), dto.getSeatsSelected(), dto.getWholeTrip(), openTripsOptional.get());
        seatingSales.setChecked(0);
        seatingSales = repository.saveAndFlush(seatingSales);

        if (seatingSales == null) {
            return new ResponseEntity<>(new Message("No se registró la venta del lugar", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(seatingSales, "Se registró la venta del lugar", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(SeatingSalesDto dto) throws SQLException {
        Optional<SeatingSales> optionalSeatingSales = repository.findById(dto.getId());
        if (!optionalSeatingSales.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el asiento vendido", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<User> userOptional = userRepository.findById(dto.getClient().getId());
        if (!userOptional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró al cliente", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<OpenTrips> openTripsOptional = openTripsRepository.findById(dto.getOpenTrips().getId());
        if (!openTripsOptional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        SeatingSales seatingSales = optionalSeatingSales.get();

        seatingSales.setStartAddress(new Address(dto.getStartAddress().getId()));
        seatingSales.setEndAddress(new Address(dto.getEndAddress().getId()));
        seatingSales.setCost(dto.getCost());
        seatingSales.setSeatsSelected(dto.getSeatsSelected());
        seatingSales.setClient(userOptional.get());
        seatingSales.setOpenTrips(openTripsOptional.get());

        seatingSales = repository.saveAndFlush(seatingSales);

        if (seatingSales == null) {
            return new ResponseEntity<>(new Message("No se modificó la venta de lugar", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(seatingSales, "Se modificó la venta de lugar", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> checkAssist(SeatingSalesDto dto) throws SQLException {

        if (dto.getChecked() < 0 && dto.getChecked() > 2) {
            return new ResponseEntity<>(new Message("El estado de la asistencia no existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }

        Optional<SeatingSales> optionalSeatingSales = repository.findById(dto.getId());
        if (!optionalSeatingSales.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el asiento vendido", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        SeatingSales seatingSales = optionalSeatingSales.get();
        seatingSales.setChecked(dto.getChecked());

        seatingSales = repository.saveAndFlush(seatingSales);

        if (seatingSales == null) {
            return new ResponseEntity<>(new Message("No se registró el estado de la asistencia", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message("Se registró el estado de la asistencia", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(readOnly = true)
    public ResponseEntity<Object> countTripsByClient(Long client_id) {
        long trips = repository.countTripsByClient(client_id);
        return new ResponseEntity<>(new Message(trips, "Cantidad de viajes realizados por el cliente", TypesResponse.SUCCESS), HttpStatus.OK);
    }

}
