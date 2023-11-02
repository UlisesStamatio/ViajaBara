package mx.edu.utez.viajabara.basecatalog.paymentMethod.control;

import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserDto;
import mx.edu.utez.viajabara.basecatalog.paymentMethod.model.PaymentMethod;
import mx.edu.utez.viajabara.basecatalog.paymentMethod.model.PaymentMethodDto;
import mx.edu.utez.viajabara.basecatalog.paymentMethod.model.PaymentMethodRepository;
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
import java.util.Optional;

@Transactional
@Service
public class PaymentMethodService {
    private final static Logger logger = LoggerFactory.getLogger(PaymentMethodService.class);

    private final PaymentMethodRepository repository;

    @Autowired
    public PaymentMethodService(PaymentMethodRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAll() {
        return new ResponseEntity<>(new Message(repository.findAll(), "Listado de metodos de pago", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled() {
        return new ResponseEntity<>(new Message(repository.findAllByStatusIsTrue(), "Listado de metodos de pago activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public Optional<PaymentMethod> findById(Long id) {
        return repository.findById(id);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(Long id) {
        Optional<PaymentMethod> optionalPaymentMethod = repository.findById(id);
        return optionalPaymentMethod.<ResponseEntity<Object>>map(method -> new ResponseEntity<>(new Message(method, "Método encontrado", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Método no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(PaymentMethodDto dto) throws SQLException {
        Optional<PaymentMethod> optional = repository.searchByNameAndId(dto.getName(), 0L);
        if (optional.isPresent()) {
            return new ResponseEntity<>(new Message("El nombre del metodo de pago ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        PaymentMethod paymentMethod = new PaymentMethod(dto.getName(),dto.getApikey(), true);
        paymentMethod = repository.saveAndFlush(paymentMethod);
        if (paymentMethod == null) {
            return new ResponseEntity<>(new Message("No se registró el metodo de pago", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(paymentMethod, "Se registró el metodo de pago", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(PaymentMethodDto dto) throws SQLException {
        Optional<PaymentMethod> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el metodo de pago", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        Optional<PaymentMethod> optionalPaymentMethod = repository.searchByNameAndId(dto.getName(), dto.getId());
        if (optionalPaymentMethod.isPresent()) {
            return new ResponseEntity<>(new Message("El nombre del metodo de pago ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        PaymentMethod paymentMethod = optional.get();
        paymentMethod.setName(dto.getName());
        paymentMethod.setApikey(dto.getApikey());
        paymentMethod = repository.saveAndFlush(paymentMethod);
        if (paymentMethod == null) {
            return new ResponseEntity<>(new Message("No se modificó el  metodo de pago", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(paymentMethod, "Se modificó el metodo de pago", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeStatus(PaymentMethodDto dto) {
        Optional<PaymentMethod> optional = repository.findById(dto.getId());
        if (!optional.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el metodo de pago", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        PaymentMethod paymentMethod = optional.get();
        paymentMethod.setStatus(!paymentMethod.isStatus());
        paymentMethod = repository.saveAndFlush(paymentMethod);
        if (paymentMethod == null) {
            return new ResponseEntity<>(new Message("No se modificó el metodo de pago", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(paymentMethod, "Se modificó el metodo de pago", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public Optional<PaymentMethod> findByName(String name) {
        return repository.findFirstByName(name);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public PaymentMethod saveInitialDuty(PaymentMethod paymentMethod) {
        return repository.saveAndFlush(paymentMethod);
    }

}
