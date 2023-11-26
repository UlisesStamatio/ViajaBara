package mx.edu.utez.viajabara.basecatalog.stopover.control;

import mx.edu.utez.viajabara.basecatalog.route.model.Route;
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
public class StopOverService {
    private final static Logger logger = LoggerFactory.getLogger(StopOverService.class);

    private final StopOverRepository repository;

    @Autowired
    public StopOverService(StopOverRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll(Route route) {
        return new ResponseEntity<>(new Message(repository.findAllByRoute(route), "Listado de paradas por ruta", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(List<StopOver> stopOverList) throws SQLException {

        List<StopOver> stopOversCreated = new ArrayList<>();
        boolean repeated = false;
        StopOver stop;

        for (StopOver stopOver:stopOverList) {
            Optional<StopOver> optionalStopOver = repository.findFirstByAddressAndRoute(stopOver.getAddress(),stopOver.getRoute());
            if (optionalStopOver.isPresent()) {
                repeated = true;
                break;
            }
            stop = new StopOver(stopOver.getAddress(),stopOver.getSequence(), stopOver.getMeters(), stopOver.getTime(),true,stopOver.getRoute());
            stop = repository.saveAndFlush(stop);
            stopOversCreated.add(stop);
        }

        if(repeated){
            return new ResponseEntity<>(new Message(stopOversCreated,"No se registraron todas la paradas", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(new Message(stopOversCreated, "Se registraron las paradas", TypesResponse.SUCCESS), HttpStatus.OK);
    }

}
