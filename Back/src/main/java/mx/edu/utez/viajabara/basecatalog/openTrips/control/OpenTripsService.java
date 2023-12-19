package mx.edu.utez.viajabara.basecatalog.openTrips.control;

import com.fasterxml.jackson.databind.ObjectMapper;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.bus.model.BusRepository;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTrips;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsDto;
import mx.edu.utez.viajabara.basecatalog.openTrips.model.OpenTripsRepository;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesRepository;
import mx.edu.utez.viajabara.basecatalog.trip.model.BookTripDto;
import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripRepository;
import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripSchedule;
import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripScheduleRepository;
import mx.edu.utez.viajabara.utils.entity.Message;
import mx.edu.utez.viajabara.utils.entity.TypesResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Transactional
@Service
public class OpenTripsService {
    private final OpenTripsRepository repository;
    private final TripRepository tripRepository;
    private final BusRepository busRepository;
    private final UserRepository userRepository;
    private final SeatingSalesRepository seatingSalesRepository;

    private final TripScheduleRepository tripScheduleRepository;

    @Autowired
    public OpenTripsService(OpenTripsRepository repository, TripRepository tripRepository, BusRepository busRepository,
                            UserRepository userRepository, SeatingSalesRepository seatingSalesRepository,TripScheduleRepository tripScheduleRepository ) {
        this.repository = repository;
        this.tripRepository = tripRepository;
        this.busRepository = busRepository;
        this.userRepository = userRepository;
        this.seatingSalesRepository = seatingSalesRepository;
        this.tripScheduleRepository = tripScheduleRepository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll(){
        List<OpenTrips> openTripsList = repository.findAll();
        List<OpenTrips> response = new ArrayList<>();
        for (OpenTrips openTrips:openTripsList) {
            openTrips.getSchedule().getTrip().getDriver().setProfile(null);
            openTrips.getSchedule().getTrip().getBus().setImage(null);
            response.add(openTrips);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes abiertos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllTripsToday(Long driver_id){
        List<OpenTrips> openTripsList = repository.searchAllTripsToday(driver_id);
        List<OpenTrips> response = new ArrayList<>();
        for (OpenTrips openTrips:openTripsList) {
            openTrips.getSchedule().getTrip().getDriver().setProfile(null);
            openTrips.getSchedule().getTrip().getBus().setImage(null);
            response.add(openTrips);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes abiertos para hoy por conductor", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllTripsHistory(Long driver_id){
        List<OpenTrips> openTripsList = repository.searchAllTripsHistory(driver_id);
        List<OpenTrips> response = new ArrayList<>();
        for (OpenTrips openTrips:openTripsList) {
            openTrips.getSchedule().getTrip().getDriver().setProfile(null);
            openTrips.getSchedule().getTrip().getBus().setImage(null);
            response.add(openTrips);
        }
        return new ResponseEntity<>(new Message(response, "Listado de historial de viajes", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled(){
        List<OpenTrips> openTripsList = repository.searchAllByStatusActive(1);
        List<OpenTrips> response = new ArrayList<>();
        for (OpenTrips openTrips:openTripsList) {
            openTrips.getSchedule().getTrip().getDriver().setProfile(null);
            openTrips.getSchedule().getTrip().getBus().setImage(null);
            response.add(openTrips);
        }
        return new ResponseEntity<>(new Message(response, "Listado de viajes abiertos en espera", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(Long id) {
        Optional<OpenTrips> optional = repository.findById(id);
        optional.get().getSchedule().getTrip().getDriver().setProfile(null);
        return optional.<ResponseEntity<Object>>map(route -> new ResponseEntity<>(new Message(route, "Viaje abierto encontrado", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Viaje abierto no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

  /*  @Transactional(readOnly = true)
    public ResponseEntity<Object> getOpenTripByTripIdAndStartDate(int tripId, String date) {
        OpenTripsDto openTripsDto = repository.findByTripIdAndDate((long) tripId, date);
        return new ResponseEntity<>(new Message(openTripsDto, "Viaje abierto encontrado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getSeatsDistributionOfSpecificTravel(BookTripDto bookTripDto) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.parse(bookTripDto.getDate(), formatter);
        Date date = java.sql.Date.valueOf(localDate);

        OpenTripsDto openTripsDto = repository.findByTripIdAndDate((long) bookTripDto.getTripId(),date.toString());
        if (openTripsDto == null){
            return new ResponseEntity<>(new Message(new ArrayList<Integer>(), "Distrbucion de asientos no encontrado", TypesResponse.SUCCESS), HttpStatus.OK);
        }

        List<String> seatsSelectedList = seatingSalesRepository.findSeatsSelectedByCriteria((long) bookTripDto.getTripId(), date.toString(), (long)bookTripDto.getOriginId(),(long)bookTripDto.getDestinyId());
        // Realiza la unión de las listas de seatsSelected
        List<Integer> combinedSeatsSelected = seatsSelectedList.stream()
                .flatMap(seatsSelected -> {
                    try {
                        ObjectMapper objectMapper = new ObjectMapper();
                        List<String> jsonList = objectMapper.readValue(seatsSelected, List.class);
                        return jsonList.stream();
                    } catch (Exception e) {
                        System.err.println("Error al analizar JSON: " + e.getMessage());
                        return Stream.empty();
                    }
                })
                .distinct()
                .map(Integer::parseInt).sorted().collect(Collectors.toList());
        return new ResponseEntity<>(new Message(combinedSeatsSelected, "Distrbucion de asientos encontrado", TypesResponse.SUCCESS), HttpStatus.OK);

    }
*/
    private static List<Integer> convertStringListToIntList(List<String> stringList) {
        List<Integer> intList = new ArrayList<>();

        // Recorre la lista de cadenas y convierte cada elemento a entero
        for (String str : stringList) {
            try {
                intList.add(Integer.parseInt(str));
            } catch (NumberFormatException e) {
                // Maneja la excepción si no se puede convertir a entero
                System.err.println("No se puede convertir '" + str + "' a entero.");
            }
        }

        return intList;
    }
    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(OpenTripsDto dto) throws SQLException{
        Optional<Trip> tripOptional = tripRepository.findById(dto.getIdTrip());

        if(!tripOptional.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje", TypesResponse.ERROR), HttpStatus.NOT_FOUND);
        }

        Trip tripSearched = tripOptional.get();
        if(tripSearched.isOpened()){
            return new ResponseEntity<>(new Message("El viaje ya se encuentra abierto", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }


        if(dto.getSchedule().size() > 0){
            List<OpenTrips> openTripsCreated = new ArrayList<>();
            List<TripSchedule> schedules = dto.getSchedule();
            for ( TripSchedule schedule : schedules) {
                Optional<TripSchedule> tripScheduleOptional = tripScheduleRepository.findById(schedule.getId());
                if(!tripScheduleOptional.isPresent()){
                    return new ResponseEntity<>(new Message("No se encontró el horario", TypesResponse.ERROR), HttpStatus.NOT_FOUND);
                }
                OpenTrips openTrips = new OpenTrips(schedule, 1);
                openTrips = repository.saveAndFlush(openTrips);
                if (openTrips == null){
                    return new ResponseEntity<>(new Message("Los viajes abiertos no se han registrado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
                }
                openTripsCreated.add(openTrips);
            }
            return new ResponseEntity<>(new Message(openTripsCreated, "Viajes abierto registrados", TypesResponse.SUCCESS), HttpStatus.OK);
        }else{
            return new ResponseEntity<>(new Message("Viaje abierto no registrado. Agregar horarios.", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

    }

  /*  @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> saveBook(BookTripDto dto) throws SQLException{
        OpenTripsDto openTripsDto = repository.findByTripIdAndDate((long) dto.getTripId(), dto.getDate());
        OpenTrips openTrips = new OpenTrips();
        if(openTripsDto != null){
            SeatingSales seatingSales = new SeatingSales();
            seatingSales.setChecked(0);
            seatingSales.setCost(new BigDecimal(dto.getPrice()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
            seatingSales.setSeating(dto.getSeats());
            seatingSales.setSeatsSelected(dto.getSeatsSelected());
            seatingSales.setWholeTrip(1);
            User user = new User();
            user.setId((long)dto.getClientId());
            seatingSales.setClient(user);
            Address startAddress = new Address((long)dto.getOriginId());
            Address endAddress = new Address((long)dto.getDestinyId());
            seatingSales.setEndAddress(endAddress);
            seatingSales.setStartAddress(startAddress);
            openTrips.setId(openTripsDto.getId());
            openTrips.setEnableSeats(openTripsDto.getEnableSeats() - dto.getSeats());
            openTrips.setCreatedAt(openTripsDto.getCreatedAt());
            openTrips.setTrip(openTripsDto.getTrip());
            openTrips.setStartDate(openTripsDto.getStartDate());
            openTrips.setStatus(openTripsDto.getStatus());
            seatingSales.setOpenTrips(openTrips);
            seatingSalesRepository.save(seatingSales);
            repository.save(openTrips);
            return new ResponseEntity<>(new Message(null,"Asientos registrados", TypesResponse.SUCCESS), HttpStatus.OK);
        }
        openTrips.setEnableSeats(20 - dto.getSeats());
        openTrips.setStartDate(parseDate(dto.getDate()));
        openTrips.setStatus(1);
        Trip trip = new Trip();
        trip.setId((long)dto.getTripId());
        openTrips.setTrip(trip);
        openTrips = repository.save(openTrips);

        SeatingSales seatingSales = new SeatingSales();
        seatingSales.setChecked(0);
        seatingSales.setCost(new BigDecimal(dto.getPrice()).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
        seatingSales.setSeating(dto.getSeats());
        seatingSales.setSeatsSelected(dto.getSeatsSelected());
        seatingSales.setWholeTrip(1);
        User user = new User();
        user.setId((long)dto.getClientId());
        seatingSales.setClient(user);
        Address startAddress = new Address((long)dto.getOriginId());
        Address endAddress = new Address((long)dto.getDestinyId());
        seatingSales.setEndAddress(endAddress);
        seatingSales.setStartAddress(startAddress);
        seatingSales.setOpenTrips(openTrips);
        seatingSales = seatingSalesRepository.save(seatingSales);

        return new ResponseEntity<>(new Message(null,"Asientos registrados", TypesResponse.SUCCESS), HttpStatus.OK);
    }*/

    private Date parseDate(String timeString) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setTimeZone(TimeZone.getTimeZone("America/Mexico_City"));
            return sdf.parse(timeString);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
   /* @Transactional(rollbackFor = {SQLException.class})
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
    }*/

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

    @Transactional(readOnly = true)
    public ResponseEntity<Object> countTripsByDriver(Long driver_id){
        long trips = repository.countTripsByDriver(driver_id);
        return new ResponseEntity<>(new Message(trips, "Cantidad de viajes realizados por el conductor", TypesResponse.SUCCESS), HttpStatus.OK);
    }

}
