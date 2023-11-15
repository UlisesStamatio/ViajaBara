package mx.edu.utez.viajabara.basecatalog.trip.control;


import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusRepository;
import mx.edu.utez.viajabara.basecatalog.route.control.RouteService;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteRepository;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripDto;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripRepository;
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
public class TripService {
    private final static Logger logger = LoggerFactory.getLogger(RouteService.class);

    private final TripRepository repository;
    private final UserRepository userRepository;
    private final BusRepository busRepository;
    private final RouteRepository routeRepository;

    @Autowired
    public TripService(TripRepository repository, UserRepository userRepository, BusRepository busRepository, RouteRepository routeRepository) {
        this.repository = repository;
        this.userRepository = userRepository;
        this.busRepository = busRepository;
        this.routeRepository = routeRepository;
    }


    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        List<Trip> trips = repository.findAll();
        List<Trip> response = new ArrayList<>();
        for (Trip trip:trips) {
            trip.getDriver().setProfile(null);
            trip.getBus().setImage(null);
            response.add(trip);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled() {
        List<Trip> trips = repository.findAllByStatusIsTrue();
        List<Trip> response = new ArrayList<>();
        for (Trip trip:trips) {
            trip.getDriver().setProfile(null);
            trip.getBus().setImage(null);
            response.add(trip);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(Long id) {
        Optional<Trip> optional = repository.findById(id);
        return optional.<ResponseEntity<Object>>map(route -> new ResponseEntity<>(new Message(route, "Viaje encontrado", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Ruta no encontrada", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(TripDto dto) throws SQLException {
        Optional<Bus> bus = busRepository.findById(dto.getBus().getId());
        if(!bus.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el autobús", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<User> driver = userRepository.findById(dto.getDriver().getId());
        if(!driver.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el conductor", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<Route> route = routeRepository.findById(dto.getRoute().getId());
        if(!route.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Trip trip = new Trip(driver.get(),bus.get(),route.get(),true);
        trip = repository.saveAndFlush(trip);
        if (trip == null) {
            return new ResponseEntity<>(new Message("No se registró el viaje", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(trip, "Se registró el viaje", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(TripDto dto) throws SQLException {
        Optional<Trip> optionalTrip = repository.findById(dto.getId());
        if(!optionalTrip.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<Bus> bus = busRepository.findById(dto.getBus().getId());
        if(!bus.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el autobús", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<User> driver = userRepository.findById(dto.getDriver().getId());
        if(!driver.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el conductor", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<Route> route = routeRepository.findById(dto.getRoute().getId());
        if(!route.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Trip trip = optionalTrip.get();
        trip.setBus(bus.get());
        trip.setDriver(driver.get());
        trip.setRoute(route.get());

        trip = repository.saveAndFlush(trip);
        if (trip == null) {
            return new ResponseEntity<>(new Message("No se modificó el viaje", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(trip, "Se modificó el viaje", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeStatus(TripDto dto) {
        Optional<Trip> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el viaje", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Trip trip = optional.get();
        trip.setStatus(!trip.isStatus());
        trip = repository.saveAndFlush(trip);

        if (trip == null) {
            return new ResponseEntity<>(new Message("No se modificó el viaje", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(trip, "Se modificó el viaje", TypesResponse.SUCCESS), HttpStatus.OK);
    }

}
