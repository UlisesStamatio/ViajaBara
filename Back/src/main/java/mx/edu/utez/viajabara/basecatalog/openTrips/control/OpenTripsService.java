package mx.edu.utez.viajabara.basecatalog.openTrips.control;

import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusRepository;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsDto;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsRepository;
import mx.edu.utez.viajabara.basecatalog.trip.model.BookTripDto;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripRepository;
import mx.edu.utez.viajabara.utils.entity.Message;
import mx.edu.utez.viajabara.utils.entity.TypesResponse;
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
public class OpenTripsService {
    private final OpenTripsRepository repository;
    private final TripRepository tripRepository;
    private final BusRepository busRepository;
    private final UserRepository userRepository;

    @Autowired
    public OpenTripsService(OpenTripsRepository repository, TripRepository tripRepository, BusRepository busRepository, UserRepository userRepository) {
        this.repository = repository;
        this.tripRepository = tripRepository;
        this.busRepository = busRepository;
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll(){
        List<OpenTrips> openTripsList = repository.findAll();
        List<OpenTrips> response = new ArrayList<>();
        for (OpenTrips openTrips:openTripsList) {
            openTrips.getTrip().getDriver().setProfile(null);
            openTrips.getTrip().getBus().setImage(null);
            response.add(openTrips);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes abiertos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled(){
        List<OpenTrips> openTripsList = repository.searchAllByStatusActive(1);
        List<OpenTrips> response = new ArrayList<>();
        for (OpenTrips openTrips:openTripsList) {
            openTrips.getTrip().getDriver().setProfile(null);
            openTrips.getTrip().getBus().setImage(null);
            response.add(openTrips);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes abiertos en espera", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(Long id) {
        Optional<OpenTrips> optional = repository.findById(id);
        return optional.<ResponseEntity<Object>>map(route -> new ResponseEntity<>(new Message(route, "Viaje abierto encontrado", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Viaje abierto no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOpenTripByTripIdAndStartDate(int tripId, String date) {
        OpenTripsDto openTripsDto = repository.findByTripIdAndDate((long) tripId, date);
        return new ResponseEntity<>(new Message(openTripsDto, "Viaje abierto encontrado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(OpenTripsDto dto) throws SQLException{

        Optional<Trip> optionalTrip = tripRepository.findById(dto.getTrip().getId());
        if(!optionalTrip.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        OpenTrips openTrips = new OpenTrips(optionalTrip.get(),dto.getStartDate(),1);
        openTrips = repository.saveAndFlush(openTrips);

        if (openTrips == null){
            return new ResponseEntity<>(new Message("Viaje abierto no registrado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(openTrips, "Viaje abierto registrado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(OpenTripsDto dto) throws SQLException{

        Optional<OpenTrips> optionalOpenTrips = repository.findById(dto.getId());
        if(!optionalOpenTrips.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        Optional<Trip> optionalTrip = tripRepository.findById(dto.getTrip().getId());
        if(!optionalTrip.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        OpenTrips openTrips = optionalOpenTrips.get();
        openTrips.setTrip(optionalTrip.get());
        openTrips.setStartDate(dto.getStartDate());

        openTrips = repository.saveAndFlush(openTrips);

        if (openTrips == null){
            return new ResponseEntity<>(new Message("Viaje abierto no modificado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(openTrips, "Viaje abierto modificado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeStatus(OpenTripsDto dto) throws SQLException{

        Optional<OpenTrips> optionalOpenTrips = repository.findById(dto.getId());
        if(!optionalOpenTrips.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje abierto", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        if(dto.getStatus()<1 || dto.getStatus()>3){
            return new ResponseEntity<>(new Message("Estado inválido", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        OpenTrips openTrips = optionalOpenTrips.get();
        openTrips.setStatus(dto.getStatus());

        openTrips = repository.saveAndFlush(openTrips);

        if (openTrips == null){
            return new ResponseEntity<>(new Message("Viaje abierto no modificado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(openTrips, "Viaje abierto modificado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

}
