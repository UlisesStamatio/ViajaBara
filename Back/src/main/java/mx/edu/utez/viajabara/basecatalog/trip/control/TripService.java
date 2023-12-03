package mx.edu.utez.viajabara.basecatalog.trip.control;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusDto;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusRepository;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsDto;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsRepository;
import mx.edu.utez.viajabara.basecatalog.route.control.RouteService;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;
import mx.edu.utez.viajabara.basecatalog.route.model.RouteRepository;
import mx.edu.utez.viajabara.basecatalog.state.model.State;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOver;
import mx.edu.utez.viajabara.basecatalog.trip.model.*;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

    @Autowired
    public TripService(TripRepository repository, UserRepository userRepository, BusRepository busRepository, RouteRepository routeRepository, OpenTripsRepository openTripsRepository) {
        this.repository = repository;
        this.userRepository = userRepository;
        this.busRepository = busRepository;
        this.routeRepository = routeRepository;
        this.openTripsRepository = openTripsRepository;
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
    public ResponseEntity<Object> getStatesForFiltersByDate(String date, boolean onlyStatesAndAddresses) throws ParseException {
        List<Trip> trips = repository.findAllByStatusIsTrue();
        System.out.println("dto " + date);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date providedDate = dateFormat.parse(date);
        TimeZone timeZone = TimeZone.getTimeZone("UTC-6");
        Calendar calendar = Calendar.getInstance(timeZone);
        calendar.setTime(providedDate);
        Integer dayOfWeekInteger = calendar.get(Calendar.DAY_OF_WEEK);
        Integer dayOfYearInteger = calendar.get(Calendar.DAY_OF_YEAR);

        List<Trip> filteredTrips = getFilteredTrips(trips, dayOfWeekInteger,dayOfYearInteger);
        System.out.println("filteredTrips " + filteredTrips);

        if (onlyStatesAndAddresses ) {
        // Obtener una lista de estados sin duplicados que tienen StopOvers
        List<State> uniqueStates = getStatesWithStopOvers(filteredTrips);

        // Obtener estados de rutas que no tienen StopOvers
        List<State> statesWithoutStopOvers = getStatesWithoutStopOvers(filteredTrips);

        // Combinar ambas listas sin duplicados
        List<State> allUniqueStates = combineUniqueLists(uniqueStates, statesWithoutStopOvers);

        System.out.println(allUniqueStates);
        return new ResponseEntity<>(new Message(allUniqueStates, "Listado de viajes activos", TypesResponse.SUCCESS), HttpStatus.OK);

        }
        return new ResponseEntity<>(new Message(filteredTrips, "Listado de viajes activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findByFiltersClient(BookTripDto bookTripDto) throws ParseException {
        Message msg =  (Message) getStatesForFiltersByDate(bookTripDto.getDate(), false).getBody() ;
        List<Trip> trips = (List<Trip>) msg.getResult();
        System.out.println("trips "+trips.size());
        List<TripDto> tripsProcessed = TripDto.fromList(trips);
        List<TripDto> filteredTrips = tripsProcessed.stream()
                .filter(trip -> {
                    System.out.println("trip "+trip.getId());
                    OpenTripsDto openTripsDto = openTripsRepository.findByTripIdAndDate(trip.getId(), bookTripDto.getDate());
                    System.out.println("openTripsDto "+openTripsDto);
                    trip.setEnabledSeats(openTripsDto != null ? openTripsDto.getEnableSeats() : 20);
                    trip.getDriver().setRoles("[]");
                    trip.setBus(new Bus());
                    boolean isStartAddressMatch = trip.getRoute().getStartAddress().getId() == bookTripDto.getOriginId()
                            && trip.getRoute().getEndAddress().getId() == bookTripDto.getDestinyId();

                    if (isStartAddressMatch) {
                        trip.setFilterType(FilterType.START_ADDRESS);
                        return true;
                    }

                    boolean isStopOverMatch = trip.getRoute().getStopOvers() != null
                            && trip.getRoute().getStopOvers().stream()
                            .anyMatch(stopOver -> stopOver.getAddressDto().getId() == bookTripDto.getOriginId()
                                    && trip.getRoute().getEndAddress().getId() == bookTripDto.getDestinyId());

                    if (isStopOverMatch) {
                        trip.setFilterType(FilterType.STOP_OVER);
                        return true;
                    }


                    return false;
                })
                .collect(Collectors.toList());
        System.out.println(filteredTrips);
        return new ResponseEntity<>(new Message(filteredTrips, "Rutas encontradas", TypesResponse.SUCCESS), HttpStatus.OK);
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
    private List<Trip> getFilteredTrips(List<Trip> trips, Integer dayOfWeek, Integer dayOfYear) {
        return trips.stream()
                .filter(trip -> isDayInWorkDays(dayOfWeek, trip.getWorkDays()))
                .filter(trip ->isTripAvailable(trip, dayOfYear))
                .collect(Collectors.toList());
    }
    // Método para verificar si el día de la semana está en los días laborables del viaje
    private boolean isDayInWorkDays(Integer dayOfWeek, String workDaysJson) {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setTimeZone(TimeZone.getTimeZone("America/Mexico_City"));
        try {
            List<Integer> workDaysList = objectMapper.readValue(workDaysJson,new TypeReference<ArrayList<Integer>>() {});
            return workDaysList.contains(dayOfWeek);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    private boolean isTripAvailable(Trip trip, Integer dayOfYearSelected) {
        Date now = new Date();

        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("America/Mexico_City"));
        Date tripStartTime = parseDate(sdf.format(now));

        TimeZone timeZone = TimeZone.getTimeZone("America/Mexico_City");
        Calendar calendar = Calendar.getInstance(timeZone);
        Integer dayOfYearToday = calendar.get(Calendar.DAY_OF_YEAR);

        System.out.println("tripStartTime " + tripStartTime.getTime());
        System.out.println("currentFormattedTime " + trip.getStartTime().getTime());
        long timeDifferenceMillis = trip.getStartTime().getTime() - tripStartTime.getTime();
        System.out.println("timeDifferenceMillis " + timeDifferenceMillis);
        if (dayOfYearSelected.equals(dayOfYearToday)) {
            return timeDifferenceMillis >= 360000;
        } else {
            System.out.println("dayOfYearToday  " + (dayOfYearToday));
            System.out.println("dayOfYearSelected  " + (dayOfYearSelected));
            System.out.println("dayOfYearSelected > dayOfYearToday " + (dayOfYearSelected > dayOfYearToday));
            return dayOfYearSelected > dayOfYearToday;
        }
    }


    private List<State> getStatesWithStopOvers(List<Trip> trips) {
        return trips.stream()
                .flatMap(trip -> trip.getRoute().getStopOvers().stream().map(StopOver::getAddress).map(Address::getState))
                .distinct()
                .collect(Collectors.toList());
    }

    private List<State> getStatesWithoutStopOvers(List<Trip> trips) {
        return trips.stream()
                .filter(trip -> trip.getRoute().getStopOvers().isEmpty())
                .map(trip -> trip.getRoute().getStartAddress().getState())
                .distinct()
                .collect(Collectors.toList());
    }
    private List<State> combineUniqueLists(List<State> list1, List<State> list2) {
        return Stream.concat(list1.stream(), list2.stream())
                .distinct()
                .collect(Collectors.toList());
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
        return optional.<ResponseEntity<Object>>map(route -> new ResponseEntity<>(new Message(route, "Viaje encontrado", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Viaje no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(TripDto dto) throws SQLException {
        Optional<Bus> bus = busRepository.findById(dto.getBus().getId());
        if(!bus.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró la unidad", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<User> driver = userRepository.findById(dto.getDriver().getId());
        if(!driver.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el conductor", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<Route> route = routeRepository.findById(dto.getRoute().getId());
        if(!route.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Trip trip = new Trip(driver.get(),bus.get(),route.get(),true, dto.getStartTime(), dto.getWorkDays());
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
        Optional<Route> route = routeRepository.findById(dto.getRoute().getId());
        if(!route.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró la ruta", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }

        Trip trip = optionalTrip.get();
        trip.setBus(bus.get());
        trip.setDriver(driver.get());
        trip.setRoute(route.get());
        trip.setStartTime(dto.getStartTime());
        trip.setWorkDays(dto.getWorkDays());

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
