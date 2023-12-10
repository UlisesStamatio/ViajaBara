package mx.edu.utez.viajabara.basecatalog.qualifications.control;

import mx.edu.utez.viajabara.basecatalog.qualifications.model.Qualifications;
import mx.edu.utez.viajabara.basecatalog.qualifications.model.QualificationsDto;
import mx.edu.utez.viajabara.basecatalog.qualifications.model.QualificationsRepository;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSalesRepository;
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
public class QualificationsService {
    private final QualificationsRepository repository;
    private final SeatingSalesRepository seatingSalesRepository;

    @Autowired
    public QualificationsService(QualificationsRepository repository, SeatingSalesRepository seatingSalesRepository) {
        this.repository = repository;
        this.seatingSalesRepository = seatingSalesRepository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll(long idOpenTrip) {
        List<Qualifications> qualifications = repository.searchAllByOpenTrip(idOpenTrip);
        List<Qualifications> response = new ArrayList<>();

        for (Qualifications qualification:qualifications) {
            qualification.getSeatingSales().setOpenTrips(null);
            response.add(qualification);
        }
        return new ResponseEntity<>(new Message(response, "Listado de calificaciones por viaje", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(QualificationsDto dto) throws SQLException {
        Optional<SeatingSales> optionalSeatingSales = seatingSalesRepository.findById(dto.getSeatingSales().getId());
        if(!optionalSeatingSales.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró el viaje comprado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        if(dto.getScore()<0 || dto.getScore() > 5){
            return new ResponseEntity<>(new Message("Calificación inválida", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        Qualifications qualifications = new Qualifications(optionalSeatingSales.get(),dto.getComments(),dto.getScore());
        qualifications = repository.saveAndFlush(qualifications);
        if(qualifications == null){
            return new ResponseEntity<>(new Message("No se registró la venta del lugar", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(qualifications, "Se registró la venta del lugar", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(QualificationsDto dto) throws SQLException {
        Optional<Qualifications> optionalQualifications = repository.findById(dto.getId());
        if(!optionalQualifications.isPresent()){
            return new ResponseEntity<>(new Message("No se encontró la calificación", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        if(dto.getScore()<0 || dto.getScore() > 5){
            return new ResponseEntity<>(new Message("Calificación inválida", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        Qualifications qualifications = optionalQualifications.get();
        qualifications.setComments(dto.getComments());
        qualifications.setScore(dto.getScore());
        qualifications = repository.saveAndFlush(qualifications);
        if(qualifications == null){
            return new ResponseEntity<>(new Message("No se modificó la venta del lugar", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(qualifications, "Se modificó la venta del lugar", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> generalQualificationByDriver(Long driver_id){
        long trips;
        try {
            trips = repository.generalQualificationByDriver(driver_id);
        }catch (Exception e){
            trips = 0;
        }
        return new ResponseEntity<>(new Message(trips, "Calificación general del conductor", TypesResponse.SUCCESS), HttpStatus.OK);
    }
}
