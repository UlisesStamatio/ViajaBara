package mx.edu.utez.viajabara.basecatalog.route.control;

import mx.edu.utez.viajabara.basecatalog.address.control.AddressService;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressDto;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressSaveDto;
import mx.edu.utez.viajabara.basecatalog.duty.model.DutyRepository;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteDto;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteRepository;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteSaveDto;
import mx.edu.utez.viajabara.basecatalog.stopover.control.StopOverService;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOver;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOverDto;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOverRepository;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOverSaveDto;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripRepository;
import mx.edu.utez.viajabara.basecatalog.way.model.Way;
import mx.edu.utez.viajabara.basecatalog.way.model.WayRepository;
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
public class RouteService {
    private final static Logger logger = LoggerFactory.getLogger(RouteService.class);

    private final RouteRepository repository;
    private final DutyRepository dutyRepository;
    private final StopOverService stopOverService;

    private final AddressService addressService;
    private final StopOverRepository stopOverRepository;

    private TripRepository tripRepository;

    private WayRepository wayRepository;


    @Autowired
    public RouteService(RouteRepository repository, DutyRepository dutyRepository,
                        StopOverService stopOverService, StopOverRepository stopOverRepository, AddressService addressService,
                        TripRepository tripRepository, WayRepository wayRepository) {
        this.repository = repository;
        this.dutyRepository = dutyRepository;
        this.stopOverService = stopOverService;
        this.stopOverRepository = stopOverRepository;
        this.addressService = addressService;
        this.tripRepository = tripRepository;
        this.wayRepository = wayRepository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        return new ResponseEntity<>(new Message(repository.findAllByOrderByStatusDesc(), "Listado de rutas", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled() {
        return new ResponseEntity<>(new Message(repository.findAllByStatusIsTrue(), "Listado de rutas activas", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(Long id) {
        Optional<Route> optional = repository.findById(id);
        return optional.<ResponseEntity<Object>>map(route -> new ResponseEntity<>(new Message(route, "Ruta encontrada", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Ruta no encontrada", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(RouteSaveDto dto) throws SQLException {

        Route route = new Route( dto.getName(), dto.getMeters(), dto.getTime(), true );

        route = repository.saveAndFlush(route);
        if (route == null) {
            return new ResponseEntity<>(new Message("No se registró la ruta", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        if (dto.getStopOvers() != null) {
            List<StopOver> stopOverList = new ArrayList<>();
            for (StopOverSaveDto stop : dto.getStopOvers()) {
                AddressSaveDto stopAdressDto = new AddressSaveDto( stop.getLatitude(),  stop.getLongitude(), stop.getDescription(), stop.getState());
                Address stopAddress = addressService.save(stopAdressDto);
                if(stopAddress == null){
                    return new ResponseEntity<>(new Message("No se registró la parada, el estado es inexistente", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
                }else{
                    StopOver stopOver = new StopOver();
                    stopOver.setRoute(route);
                    stopOver.setSequence(stop.getSequence());
                    stopOver.setMeters(stop.getMeters());
                    stopOver.setTime(stop.getTime());
                    stopOver.setAddress(stopAddress);
                    stopOverList.add(stopOver);
                }

            }
            stopOverService.save(stopOverList);
        }


        return new ResponseEntity<>(new Message(route, "Se registró la ruta", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(RouteSaveDto dto) throws SQLException {
        Optional<Route> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Route route = optional.get();
        List<StopOver> firstStopOverList = route.getStopOvers();
        for (StopOver stop : firstStopOverList) {
            System.out.println(stop.toString());
            stop.setRoute(null);
            stop.setAddress(null);
            stopOverRepository.saveAndFlush(stop);
            stopOverRepository.delete(stop);
        }

        if (dto.getStopOvers() != null) {
            List<StopOver> stopOverList = new ArrayList<>();
            for (StopOverSaveDto stop : dto.getStopOvers()) {
                AddressSaveDto stopAdressDto = new AddressSaveDto( stop.getLatitude(),  stop.getLongitude(), stop.getDescription(), stop.getState());
                Address stopAddress = addressService.save(stopAdressDto);
                if(stopAddress == null){
                    return new ResponseEntity<>(new Message("No se registró la parada, el estado es inexistente", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
                }else{
                    StopOver stopOver = new StopOver();
                    stopOver.setRoute(route);
                    stopOver.setAddress(stopAddress);
                    stopOver.setTime(stop.getTime());
                    stopOver.setMeters(stop.getMeters());
                    stopOver.setSequence(stop.getSequence());
                    stopOver.setAddress(stopAddress);
                    stopOverList.add(stopOver);
                }
            }
            stopOverService.save(stopOverList);
        }

        route.setName(dto.getName());
        route.setMeters(dto.getMeters());
        route.setTime(dto.getTime());


        route = repository.saveAndFlush(route);
        if (route == null) {
            return new ResponseEntity<>(new Message("No se registró la ruta", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(route, "Se registró la ruta", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeStatus(RouteDto dto) {
        Optional<Route> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Route route = optional.get();

        Optional<Way> optionalWay = wayRepository.findByRouteIdAndTripStatusIsTrue(route.getId());
        if(optionalWay.isPresent() && route.isStatus()){
            return new ResponseEntity<>(new Message("La ruta se encuentra en un viaje, no puedes deshabilitarla", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }

        route.setStatus(!route.isStatus());
        route = repository.saveAndFlush(route);

        if (route == null) {
            return new ResponseEntity<>(new Message("No se modificó la ruta", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(route, "Se modificó la ruta", TypesResponse.SUCCESS), HttpStatus.OK);
    }
}
