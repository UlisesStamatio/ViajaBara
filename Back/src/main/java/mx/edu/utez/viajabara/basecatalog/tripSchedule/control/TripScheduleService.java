package mx.edu.utez.viajabara.basecatalog.tripSchedule.control;

import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.trip.model.TripRepository;
import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripSchedule;
import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripScheduleRepository;
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
public class TripScheduleService {

    private final static Logger logger = LoggerFactory.getLogger(TripScheduleService.class);

    private final TripScheduleRepository repository;

    private final TripRepository tripRepository;


    @Autowired
    public TripScheduleService(TripScheduleRepository repository, TripRepository tripRepository) {
        this.repository = repository;
        this.tripRepository = tripRepository;
    }


    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> saveAll(List<TripSchedule> tripSchedules) throws SQLException {

        List<TripSchedule> tripSchedulesCreated = new ArrayList<>();
        boolean repeated = false;
        boolean existTrip = true;
        TripSchedule tripScheduleCreate;

        for (TripSchedule tripSchedule:tripSchedules) {
            Optional<TripSchedule> tripScheduleOptional = repository.findByStartDateAndEndDateAndTripId(tripSchedule.getStartDate(), tripSchedule.getEndDate(), tripSchedule.getTrip().getId());
            if (tripScheduleOptional.isPresent()) {
                repeated = true;
                break;
            }
            Optional<Trip> tripOptional = tripRepository.findById(tripSchedule.getTrip().getId());
            if(!tripOptional.isPresent()){
                existTrip = false;
                break;
            }
            tripScheduleCreate = new TripSchedule(tripSchedule.getStartDate(), tripSchedule.getEndDate(), tripSchedule.getTrip(), tripSchedule.isStatus());
            tripScheduleCreate = repository.saveAndFlush(tripScheduleCreate);
            tripSchedulesCreated.add(tripScheduleCreate);
        }

        if(!existTrip){
            return new ResponseEntity<>(new Message(null,"El trip ingresado es inexistente", TypesResponse.ERROR), HttpStatus.NOT_FOUND);
        }

        if(repeated){
            return new ResponseEntity<>(new Message(tripSchedulesCreated,"No se registraron todas las rutas", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(tripSchedulesCreated, "Se registraron las rutas", TypesResponse.SUCCESS), HttpStatus.OK);
    }
}
