package mx.edu.utez.viajabara.basecatalog.trip.control;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.address.model.AddressDto;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusDto;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusRepository;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsDto;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsRepository;
import mx.edu.utez.viajabara.basecatalog.person.model.Person;
import mx.edu.utez.viajabara.basecatalog.route.control.RouteService;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteDto;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteRepository;
import mx.edu.utez.viajabara.basecatalog.state.model.State;
import mx.edu.utez.viajabara.basecatalog.state.model.StateBookTripDto;
import mx.edu.utez.viajabara.basecatalog.state.model.StateDto;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOver;
import mx.edu.utez.viajabara.basecatalog.trip.model.*;
import mx.edu.utez.viajabara.basecatalog.way.control.WayService;
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

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Transactional
@Service
public class TripService {
    private final static Logger logger = LoggerFactory.getLogger(RouteService.class);

    private final TripRepository repository;
    private final UserRepository userRepository;
    private final BusRepository busRepository;
    private final RouteRepository routeRepository;

    private final OpenTripsRepository openTripsRepository;

    private final WayService wayService;

    private final WayRepository wayRepository;

    @Autowired
    public TripService(TripRepository repository, UserRepository userRepository, BusRepository busRepository, RouteRepository routeRepository, OpenTripsRepository openTripsRepository, WayService wayService, WayRepository wayRepository) {
        this.repository = repository;
        this.userRepository = userRepository;
        this.busRepository = busRepository;
        this.routeRepository = routeRepository;
        this.openTripsRepository = openTripsRepository;
        this.wayService = wayService;
        this.wayRepository = wayRepository;
    }


    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {

        List<Trip> trips = repository.findAll();
        List<ListTripsDto> response = new ArrayList<>();
        for (Trip trip:trips) {
            trip.getDriver().setProfile(null);
            trip.getBus().setImage(null);
            ListTripsDto tripsDto = new ListTripsDto();
            tripsDto.setBus(trip.getBus());
            tripsDto.setDriver(trip.getDriver());
            tripsDto.setId(trip.getId());
            tripsDto.setMeters(trip.getMeters());
            tripsDto.setStatus(trip.isStatus());
            tripsDto.setStopovers(trip.getStopovers());
            tripsDto.setTime(trip.getTime());
            tripsDto.setStartTime(trip.getStartTime());
            tripsDto.setWorkDays(trip.getWorkDays());
            tripsDto.setCreatedAt(trip.getCreatedAt());

            List<Way> ways = wayRepository.findByTripId(trip.getId());
            tripsDto.setWays(ways);
            response.add(tripsDto);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes", TypesResponse.SUCCESS), HttpStatus.OK);
    }
    @Transactional(readOnly = true)
    public ResponseEntity<Object> getStatesForFiltersByDate(String date, boolean onlyStatesAndAddresses) throws ParseException {
        System.out.println("dto " + date);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date providedDate = dateFormat.parse(date);
        TimeZone timeZone = TimeZone.getTimeZone("UTC-6");
        Calendar calendar = Calendar.getInstance(timeZone);
        calendar.setTime(providedDate);
        int dayOfWeekInteger = calendar.get(Calendar.DAY_OF_WEEK);
        List<Trip> trips = repository.findTripsAvailableInDay(Integer.toString(dayOfWeekInteger));
        for (Trip trip: trips
             ) {
            System.out.println(trip);
        }

        int dayOfYearInteger = calendar.get(Calendar.DAY_OF_YEAR);
        List<Trip> filteredTrips = getFilteredTrips(trips,dayOfYearInteger);
        System.out.println("filteredTrips " + filteredTrips);

        if (onlyStatesAndAddresses ) {
            List<StateBookTripDto> statesProcessed = processTrips(filteredTrips);
            System.out.println("statesProcessed");
            return new ResponseEntity<>(new Message(statesProcessed, "Listado de viajes activos", TypesResponse.SUCCESS), HttpStatus.OK);
        }
        return new ResponseEntity<>(new Message(filteredTrips, "Listado de viajes activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }
    private List<StateBookTripDto> processTrips(List<Trip> trips) {
        Map<Long, StateBookTripDto> stateMap = new HashMap<>();
        Set<Long> uniqueAddresses = new HashSet<>();

        for (Trip trip : trips) {
            for (Way way : trip.getWays()) {
                for (StopOver stopOver : way.getRoute().getStopOvers()) {
                    Address address = stopOver.getAddress();
                    State state = address.getState();

                    // Verifica si ya existe el StateBookTripDto para el estado
                    StateBookTripDto stateBookTripDto = stateMap.computeIfAbsent(
                            state.getId(),
                            id -> {
                                StateBookTripDto newDto = new StateBookTripDto();
                                newDto.setId(state.getId());
                                newDto.setName(state.getName());
                                newDto.setAddressDtos(new ArrayList<>());
                                return newDto;
                            }
                    );

                    // Verifica si la dirección ya fue procesada
                    if (uniqueAddresses.add(address.getId())) {
                        // Crea el AddressDto para la dirección
                        AddressDto addressDto = new AddressDto();
                        addressDto.setId(address.getId());
                        addressDto.setLatitude(address.getLatitude());
                        addressDto.setLongitude(address.getLongitude());
                        addressDto.setDescription(address.getDescription());

                        // Agrega el AddressDto a la lista de direcciones del StateBookTripDto
                        stateBookTripDto.getAddressDtos().add(addressDto);
                    }
                }
            }
        }

        // Devuelve la lista de StateBookTripDto
        return new ArrayList<>(stateMap.values());
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findByFiltersClient(BookTripDto bookTripDto) throws ParseException {
        Message msg = (Message) getStatesForFiltersByDate(bookTripDto.getDate(), false).getBody() ;
        List<Trip> trips = (List<Trip>) msg.getResult();
        Set<Trip> uniqueTrips = new HashSet<>(trips);
        List<Trip> uniqueTripsList = new ArrayList<>(uniqueTrips);
        System.out.println("trips "+uniqueTripsList.size());
        List<TripDto> tripsProcessed = TripDto.fromList(uniqueTripsList);
        List<TripDto> filteredTrips = tripsProcessed.stream()
                .filter(trip -> {
                    try {
                        List<StopOver> stopOvers = new StopOver().parseStopOversFromJson(trip.getStopovers());
                        List<StopOver> stopOversProcessed = filterStopOvers(stopOvers,(long) bookTripDto.getOriginId(),(long) bookTripDto.getDestinyId());
                        if (stopOversProcessed.isEmpty()){
                            return false;
                        }
                        System.out.println("stopOvers.get(0).getId() ");
                        System.out.println(stopOvers.get(0).getId());
                        System.out.println("stopOversProcessed.get(0).getId() ");
                        System.out.println(stopOversProcessed.get(0).getId());

                        System.out.println("stopOvers.get(stopOvers.size() - 1).getId() ");
                        System.out.println(stopOvers.get(stopOvers.size() - 1).getId());
                        System.out.println("stopOversProcessed.get(stopOversProcessed.size() - 1).getId())  ");
                        System.out.println(stopOversProcessed.get(stopOversProcessed.size() - 1).getId());
                        if (Objects.equals(stopOvers.get(0).getId(), stopOversProcessed.get(0).getId()) &&
                                Objects.equals(stopOvers.get(stopOvers.size() - 1).getId(), stopOversProcessed.get(stopOversProcessed.size() - 1).getId()) ){
                            trip.setFilterType(FilterType.FULL_TRAVEL);
                        }else{
                            trip.setFilterType(FilterType.STOPPER);
                        }
                        ObjectMapper objectMapper = new ObjectMapper();
                        String jsonArray = objectMapper.writeValueAsString(stopOversProcessed);
                        OpenTripsDto openTripsDto = openTripsRepository.findByTripIdAndDate(trip.getId(), bookTripDto.getDate());
                        trip.setEnabledSeats(openTripsDto != null ? openTripsDto.getEnableSeats() : 20);
                        trip.getDriver().setRoles("[]");
                        trip.getDriver().setPerson(null);
                        trip.setBus(new Bus());
                        trip.setStopovers(jsonArray);

                        return true;
                    } catch (JsonProcessingException e) {
                        System.out.println("findByFiltersClient "+e);
                        return false;
                    }
                })
                .collect(Collectors.toList());
        return new ResponseEntity<>(new Message(filteredTrips, "Rutas encontradas", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    private List<StopOver> filterStopOvers(List<StopOver> stopOvers, Long originId, Long endId) {
        List<StopOver> filteredStopOvers = new ArrayList<>();
        // Obtén los stopovers que cumplen con las condiciones de los IDs
        List<StopOver> validStopOvers = stopOvers.stream()
                .filter(stopOver -> {
                    Address address = stopOver.getAddress();
                    Long addressId = address.getId();

                    // Verifica si la dirección tiene el mismo id que originId o endId
                    if (addressId.equals(originId) || addressId.equals(endId)) {
                        // Si la dirección tiene el mismo id que originId, guarda su sequence en originSequence
                        int originSequence = (addressId.equals(originId)) ? stopOver.getSequence() : 0;

                        // Si la dirección tiene el mismo id que endId, guarda su sequence en endSequence
                        int endSequence = (addressId.equals(endId)) ? stopOver.getSequence() : 0;

                        // Retorna verdadero si la secuencia de originId es menor que la de endId
                        System.out.println(stopOver.getId());
                        System.out.println("originSequence < endSequence");
                        System.out.println(originSequence);
                        System.out.println(endSequence);
                        System.out.println(originSequence < endSequence);
                        return originSequence != 0 || endSequence != 0;
                    }
                    return false;
                })
                .collect(Collectors.toList());
        if (validStopOvers.size() <= 1 || validStopOvers.get(0).getId().equals(endId)){
            return new ArrayList<>();
        }
        boolean canAdd = false;
        for (StopOver stopOver : stopOvers) {
            Address address = stopOver.getAddress();
            Long addressId = address.getId();
            if (canAdd && addressId.equals(endId)) {
                // Detener la búsqueda cuando se encuentra el endId
                filteredStopOvers.add(stopOver);
                break;
            }
            if (addressId.equals(originId)) {
                // Habilitar la adición de StopOver cuando se encuentra el originId
                canAdd = true;
            }

            if (canAdd) {
                // Agregar StopOver si ya se encontró el originId
                filteredStopOvers.add(stopOver);
            }
        }

        return filteredStopOvers;
    }


    private Date parseDate(String timeString) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
            sdf.setTimeZone(TimeZone.getTimeZone("America/Mexico_City"));
            return sdf.parse(timeString);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
    private List<Trip> getFilteredTrips(List<Trip> trips, Integer dayOfYear) {
        return trips.stream()
                .filter(trip ->isTripAvailable(trip, dayOfYear))
                .collect(Collectors.toList());
    }

    private boolean isTripAvailable(Trip trip, Integer dayOfYearSelected) {
        Date now = new Date();

        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("America/Mexico_City"));
        Date tripStartTime = parseDate(sdf.format(now));

        TimeZone timeZone = TimeZone.getTimeZone("America/Mexico_City");
        Calendar calendar = Calendar.getInstance(timeZone);
        Integer dayOfYearToday = calendar.get(Calendar.DAY_OF_YEAR);

        long timeDifferenceMillis = trip.getStartTime().getTime() - tripStartTime.getTime();

        if (dayOfYearSelected.equals(dayOfYearToday)) {
            return timeDifferenceMillis >= 360000;
        } else {
           return dayOfYearSelected > dayOfYearToday;
        }
    }

    private Date getCurrentFormattedTime() {
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("America/Mexico_City"));
        return parseDate(sdf.format(now));
    }

    private Date getFormattedTripStartTime(Trip trip) {
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("America/Mexico_City"));
        return parseDate(sdf.format(trip.getStartTime()));
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled() {
        List<Trip> trips = repository.findAllByStatusIsTrue();
        List<ListTripsDto> response = new ArrayList<>();
        for (Trip trip:trips) {
            trip.getDriver().setProfile(null);
            trip.getBus().setImage(null);
            ListTripsDto tripsDto = new ListTripsDto();
            tripsDto.setBus(trip.getBus());
            tripsDto.setDriver(trip.getDriver());
            tripsDto.setId(trip.getId());
            tripsDto.setMeters(trip.getMeters());
            tripsDto.setStatus(trip.isStatus());
            tripsDto.setStopovers(trip.getStopovers());
            tripsDto.setTime(trip.getTime());
            tripsDto.setStartTime(trip.getStartTime());
            tripsDto.setWorkDays(trip.getWorkDays());
            tripsDto.setCreatedAt(trip.getCreatedAt());

            List<Way> ways = wayRepository.findByTripId(trip.getId());
            tripsDto.setWays(ways);
            response.add(tripsDto);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(Long id) {
        Optional<Trip> optional = repository.findById(id);
        if(!optional.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Trip trip = optional.get();
        trip.getDriver().setProfile(null);
        trip.getBus().setImage(null);
        ListTripsDto tripsDto = new ListTripsDto();
        tripsDto.setBus(trip.getBus());
        tripsDto.setDriver(trip.getDriver());
        tripsDto.setId(trip.getId());
        tripsDto.setMeters(trip.getMeters());
        tripsDto.setStatus(trip.isStatus());
        tripsDto.setStopovers(trip.getStopovers());
        tripsDto.setTime(trip.getTime());
        tripsDto.setStartTime(trip.getStartTime());
        tripsDto.setWorkDays(trip.getWorkDays());
        tripsDto.setCreatedAt(trip.getCreatedAt());
        List<Way> ways = wayRepository.findByTripId(trip.getId());
        tripsDto.setWays(ways);

        return new ResponseEntity<>(new Message(tripsDto, "Consulta realizada con éxito.", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(TripDto dto) throws SQLException {
        Optional<Bus> bus = busRepository.findById(dto.getBus().getId());
        if(!bus.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró la unidad", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<User> driver = userRepository.findById(dto.getDriver().getId());
        if(!driver.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el conductor", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Trip trip = new Trip(driver.get(), bus.get(),true, dto.getMeters(), dto.getTime(), dto.getStartTime(), dto.getWorkDays(), dto.getStopovers());
        trip = repository.saveAndFlush(trip);
        if (trip == null) {
            return new ResponseEntity<>(new Message("No se registró el viaje", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        if(dto.getWays().size() > 0 ){
            List<Way> wayList = new ArrayList<>();
            for (Way way : dto.getWays()) {
                Optional<Route> route = routeRepository.findById(way.getRoute().getId());
                if(!route.isPresent()){
                    return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
                }
                Way wayToSave = new Way();
                wayToSave.setRoute(route.get());
                wayToSave.setTrip(trip);
                wayToSave.setSequence(way.getSequence());
                wayList.add(wayToSave);
            }
            wayService.save(wayList);
        }
        return new ResponseEntity<>(new Message(trip, "Se registró el viaje", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(TripDto dto) throws SQLException {
        Optional<Trip> optionalTrip = repository.findById(dto.getId());
        if(!optionalTrip.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        List<OpenTrips> optionalOpenTrips = openTripsRepository.findOpenTripsByTripIdNotInProgress(optionalTrip.get().getId());
        if(optionalOpenTrips.size() > 0){
            return new ResponseEntity<>(new Message("El viaje esta en progreso, no puedes modificarlo", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }

        Optional<Bus> bus = busRepository.findById(dto.getBus().getId());
        if(!bus.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el autobús", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Optional<User> driver = userRepository.findById(dto.getDriver().getId());
        if(!driver.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el conductor", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        List<Way> ways = wayRepository.findByTripId(optionalTrip.get().getId());
        if(ways.size() > 0){
            for (Way way : ways){
                way.setRoute(null);
                way.setTrip(null);
                wayRepository.saveAndFlush(way);
                wayRepository.delete(way);
            }
        }

        if(dto.getWays().size() > 0 ){
            List<Way> wayList = new ArrayList<>();
            for (Way way : dto.getWays()) {
                Optional<Route> route = routeRepository.findById(way.getRoute().getId());
                if(!route.isPresent()){
                    return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
                }
                Way wayToSave = new Way();
                wayToSave.setRoute(route.get());
                wayToSave.setTrip(optionalTrip.get());
                wayToSave.setSequence(way.getSequence());
                wayList.add(wayToSave);
            }
            wayService.save(wayList);
        }

        Trip trip = optionalTrip.get();
        trip.setBus(bus.get());
        trip.setDriver(driver.get());
        trip.setStartTime(dto.getStartTime());
        trip.setWorkDays(dto.getWorkDays());
        trip.setTime(dto.getTime());
        trip.setMeters(dto.getMeters());
        trip.setStopovers(dto.getStopovers());

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

        List<OpenTrips> optionalOpenTrips = openTripsRepository.findOpenTripsByTripIdNotInProgress(optional.get().getId());
        if(optionalOpenTrips.size() > 0 && optional.get().isStatus()){
            return new ResponseEntity<>(new Message("El viaje esta en progreso, no puedes desactivarlo", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
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
