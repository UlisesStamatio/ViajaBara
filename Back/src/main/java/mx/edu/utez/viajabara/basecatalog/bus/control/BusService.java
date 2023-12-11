package mx.edu.utez.viajabara.basecatalog.bus.control;

import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusDto;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusRepository;
import mx.edu.utez.viajabara.basecatalog.typeBus.model.TypeBus;
import mx.edu.utez.viajabara.basecatalog.typeBus.model.TypeBusRepository;
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
public class BusService {

    private final static Logger logger = LoggerFactory.getLogger(BusService.class);

    private final BusRepository repository;

    private final TypeBusRepository typeBusRepository;

    @Autowired
    public BusService(BusRepository repository, TypeBusRepository typeBusRepository) {
        this.repository = repository;
        this.typeBusRepository = typeBusRepository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
       List<Bus> busList =  repository.findAllByOrderByStatusDesc();
       List<Bus> buses =  new ArrayList<>();
        for (Bus bus: busList) {
            bus.setImage(null);
            buses.add(bus);
        }
        return new ResponseEntity<>(new Message(buses, "Listado de autobuses", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled() {
        List<Bus> busList =  repository.findAllByStatusIsTrue();
        List<Bus> buses =  new ArrayList<>();
        for (Bus bus: busList) {
            bus.setImage(null);
            buses.add(bus);
        }
        return new ResponseEntity<>(new Message(buses, "Listado de autobuses activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(Long id) {
        Optional<Bus> optionalBus = repository.findById(id);
        return optionalBus.<ResponseEntity<Object>>map(bus -> new ResponseEntity<>(new Message(bus, "Autobús encontrado", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Autobús no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(BusDto dto) throws SQLException {
        Optional<Bus> optional = repository.searchByPlaqueAndId(dto.getPlaque(), 0L);
        if (optional.isPresent()) {
            return new ResponseEntity<>(new Message("La placa del autobús ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }

        Optional<TypeBus> optionalTypeBus = typeBusRepository.findById(dto.getTypeBus().getId());
        if (!optionalTypeBus.isPresent()) {
            return new ResponseEntity<>(new Message("El tipo de autobus no se ha encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Bus bus = new Bus(dto.getPlaque(),dto.getMark(),dto.getModel(),true, optionalTypeBus.get());

        if(dto.getImage() != null){
            bus.setImage(dto.getImage());
        }
        if(dto.getFuel() != null){
            bus.setFuel(dto.getFuel());
        }
        if(dto.getSerial() != null){
            Optional<Bus> optional2 = repository.searchBySerialAndId(dto.getSerial(), 0L);
            if (optional2.isPresent()) {
                return new ResponseEntity<>(new Message("El serial del autobús ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
            }
            bus.setSerial(dto.getSerial());
        }

        bus = repository.saveAndFlush(bus);
        if (bus == null) {
            return new ResponseEntity<>(new Message("No se registró el autobús", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(bus, "Se registró el autobús", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(BusDto dto) throws SQLException {
        Optional<Bus> busOptional = repository.findById(dto.getId());
        if (!busOptional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el autobús", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }

        Optional<TypeBus> optionalTypeBus = typeBusRepository.findById(dto.getTypeBus().getId());
        if (!optionalTypeBus.isPresent()) {
            return new ResponseEntity<>(new Message("El tipo de autobus no se ha encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Optional<Bus> optional = repository.searchByPlaqueAndId(dto.getPlaque(), dto.getId());
        if (optional.isPresent()) {
            return new ResponseEntity<>(new Message("La placa del autobús ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }


        Bus bus = busOptional.get();
        bus.setPlaque(dto.getPlaque());
        bus.setMark(dto.getMark());
        bus.setModel(dto.getModel());
        bus.setTypeBus(optionalTypeBus.get());
        bus.setFuel(null);
        bus.setImage(null);
        bus.setSerial(null);

        if(dto.getImage() != null){
            bus.setImage(dto.getImage());
        }
        if(dto.getFuel() != null){
            bus.setFuel(dto.getFuel());
        }
        if(dto.getSerial() != null){
            Optional<Bus> optional2 = repository.searchBySerialAndId(dto.getSerial(), dto.getId());
            if (optional2.isPresent()) {
                return new ResponseEntity<>(new Message("El serial del autobús ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
            }
            bus.setSerial(dto.getSerial());
        }


        bus = repository.saveAndFlush(bus);
        if (bus == null) {
            return new ResponseEntity<>(new Message("No se modificó el autobús", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(bus, "Se modificó el autobús", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeStatus(BusDto dto) {
        Optional<Bus> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el autobús", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Bus bus = optional.get();
        bus.setStatus(!bus.isStatus());
        bus = repository.saveAndFlush(bus);
        if (bus == null) {
            return new ResponseEntity<>(new Message("No se modificó el autobús de pago", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(bus, "Se modificó el autobús de pago", TypesResponse.SUCCESS), HttpStatus.OK);
    }

}
