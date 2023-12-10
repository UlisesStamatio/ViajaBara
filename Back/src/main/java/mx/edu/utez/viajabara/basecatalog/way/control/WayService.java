package mx.edu.utez.viajabara.basecatalog.way.control;

import mx.edu.utez.viajabara.basecatalog.stopover.control.StopOverService;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOver;
import mx.edu.utez.viajabara.basecatalog.stopover.model.StopOverRepository;
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
public class WayService {


    private final static Logger logger = LoggerFactory.getLogger(WayService.class);

    private final WayRepository repository;


    @Autowired
    public WayService(WayRepository repository) {
        this.repository = repository;
    }



    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(List<Way> wayList) throws SQLException {

        List<Way> wayListCreated = new ArrayList<>();
        boolean repeated = false;
        Way wayToCreated;

        for (Way way:wayList) {
            Optional<Way> optionalWay = repository.findFirstByTripAndRoute(way.getTrip(), way.getRoute());
            if (optionalWay.isPresent()) {
                repeated = true;
                break;
            }
            wayToCreated = new Way(way.getRoute(), way.getTrip(), way.getSequence(), true);
            wayToCreated = repository.saveAndFlush(wayToCreated);
            wayListCreated.add(wayToCreated);
        }

        if(repeated){
            return new ResponseEntity<>(new Message(wayListCreated,"No se registraron todas las rutas", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(wayListCreated, "Se registraron las rutas", TypesResponse.SUCCESS), HttpStatus.OK);
    }
}
