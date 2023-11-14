package mx.edu.utez.viajabara.basecatalog.route.control;

import mx.edu.utez.viajabara.basecatalog.duty.model.Duty;
import mx.edu.utez.viajabara.basecatalog.duty.model.DutyRepository;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteDto;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteRepository;
import mx.edu.utez.viajabara.basecatalog.stopover.control.StopOverService;
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
public class RouteService {
    private final static Logger logger = LoggerFactory.getLogger(RouteService.class);

    private final RouteRepository repository;
    private final DutyRepository dutyRepository;
    private final StopOverService stopOverService;
    private final StopOverRepository stopOverRepository;


    @Autowired
    public RouteService(RouteRepository repository, DutyRepository dutyRepository, StopOverService stopOverService, StopOverRepository stopOverRepository) {
        this.repository = repository;
        this.dutyRepository = dutyRepository;
        this.stopOverService = stopOverService;
        this.stopOverRepository = stopOverRepository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        return new ResponseEntity<>(new Message(repository.findAll(), "Listado de rutas", TypesResponse.SUCCESS), HttpStatus.OK);
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
    public ResponseEntity<Object> save(RouteDto dto) throws SQLException {
        Optional<Duty> duty = dutyRepository.findById(dto.getDuty().getId());
        if (!duty.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el servicio", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Route route = new Route(dto.getStart_latitude(), dto.getStart_longitude(), dto.getEnd_latitude(), dto.getEnd_longitude(), duty.get(), true);

        route = repository.saveAndFlush(route);
        if (route == null) {
            return new ResponseEntity<>(new Message("No se registró la ruta", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        if (dto.getStopOvers() != null) {
            List<StopOver> stopOverList = new ArrayList<>();
            for (StopOver stop : dto.getStopOvers()) {
                stop.setRoute(route);
                stopOverList.add(stop);
            }
            stopOverService.save(stopOverList);
        }


        return new ResponseEntity<>(new Message(route, "Se registró la ruta", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(RouteDto dto) throws SQLException {
        Optional<Route> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Optional<Duty> duty = dutyRepository.findById(dto.getDuty().getId());
        if (!duty.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el servicio", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Route route = optional.get();

        List<StopOver> firstStopOverList = route.getStopOvers();
        for (StopOver stop : firstStopOverList) {
            stop.setRoute(null);
            stopOverRepository.saveAndFlush(stop);
            stopOverRepository.delete(stop);
        }

        if (dto.getStopOvers() != null) {
            List<StopOver> stopOverList = new ArrayList<>();
            for (StopOver stop : dto.getStopOvers()) {
                stop.setRoute(route);
                stopOverList.add(stop);
            }
            stopOverService.save(stopOverList);
            route.setStopOvers(stopOverList);
        }

        route.setStart_latitude(dto.getStart_latitude());
        route.setStart_longitude(dto.getStart_longitude());
        route.setEnd_latitude(dto.getEnd_latitude());
        route.setEnd_longitude(dto.getEnd_longitude());
        route.setDuty(duty.get());


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
        route.setStatus(!route.isStatus());
        route = repository.saveAndFlush(route);

        if (route == null) {
            return new ResponseEntity<>(new Message("No se modificó la ruta", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(route, "Se modificó la ruta", TypesResponse.SUCCESS), HttpStatus.OK);
    }
}
