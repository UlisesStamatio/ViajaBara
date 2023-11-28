package mx.edu.utez.viajabara.access.user.control;

import com.fasterxml.jackson.core.JsonProcessingException;
import mx.edu.utez.viajabara.access.role.control.RoleService;
import mx.edu.utez.viajabara.access.role.model.Role;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.user.model.UserDto;
import mx.edu.utez.viajabara.access.user.model.UserRepository;
import mx.edu.utez.viajabara.basecatalog.person.control.PersonService;
import mx.edu.utez.viajabara.basecatalog.person.model.Person;
import mx.edu.utez.viajabara.basecatalog.person.model.PersonDto;
import mx.edu.utez.viajabara.security.dto.JwtDto;
import mx.edu.utez.viajabara.security.jwt.JwtProvider;
import mx.edu.utez.viajabara.utils.entity.Consult;
import mx.edu.utez.viajabara.utils.entity.Message;
import mx.edu.utez.viajabara.utils.entity.PaginationDto;
import mx.edu.utez.viajabara.utils.entity.TypesResponse;
import mx.edu.utez.viajabara.utils.service.EmailService;
import mx.edu.utez.viajabara.utils.validator.EmailValidator;
import mx.edu.utez.viajabara.utils.validator.PasswordValidator;
import mx.edu.utez.viajabara.utils.validator.PhoneValidator;
import org.assertj.core.internal.bytebuddy.utility.RandomString;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.*;

@Transactional
@Service
public class UserService {
    private final static Logger logger = LoggerFactory.getLogger(UserService.class);

    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final PasswordValidator passwordValidator;
    private final PhoneValidator phoneValidator;
    private final EmailValidator emailValidator;
    private final EmailService emailService;
    private final RoleService roleService;
    private final PersonService personService;

    @Lazy
    private final JwtProvider jwtProvider;


    @Autowired
    public UserService(UserRepository repository, PasswordEncoder passwordEncoder, PasswordValidator passwordValidator, PhoneValidator phoneValidator, EmailValidator emailValidator, EmailService emailService, RoleService roleService, PersonService personService, JwtProvider jwtProvider) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
        this.passwordValidator = passwordValidator;
        this.phoneValidator = phoneValidator;
        this.emailValidator = emailValidator;
        this.emailService = emailService;
        this.roleService = roleService;
        this.personService = personService;
        this.jwtProvider = jwtProvider;
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllDrivers() throws SQLException {
        List<User> users = repository.searchAllDrivers();
        List<User> userList = new ArrayList<>();
        for (User user:users) {
            user.setProfile(null);
            userList.add(user);
        }
        return new ResponseEntity<>(new Message(userList, "Listado de conductores registrados", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllDriversEnabled() throws SQLException {
        List<User> users = repository.searchAllDriversEnabled();
        List<User> userList = new ArrayList<>();
        for (User user:users) {
            user.setProfile(null);
            userList.add(user);
        }
        return new ResponseEntity<>(new Message(userList, "Listado de conductores activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllClient() throws SQLException {
        List<User> users = repository.searchAllConsumers();
        List<User> userList = new ArrayList<>();
        for (User user:users) {
            user.setProfile(null);
            userList.add(user);
        }
        return new ResponseEntity<>(new Message(userList, "Listado de clientes registrados", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> findAllEnabled() {
        return new ResponseEntity<>(new Message(repository.findAllByStatus(true), "Listado de usuarios activos", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public Optional<User> findById(Long id) {
        return repository.findById(id);
    }

    public Optional<User> findFirstByEmail(String email) {
        return repository.findFirstByEmail(email);
    }

    @Transactional(readOnly = true)
    public boolean existsByMail(String email) {
        Optional<User> optionalUser = repository.findFirstByEmail(email);
        return optionalUser.isPresent();
    }

    @Transactional(rollbackFor = {SQLException.class})
    public void saveInitialUser(User user) {
        repository.save(user);
    }

    public List<User> searchAllByRoles(String role) {
        return repository.searchAllByRole("%" + role + "%");
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeRole(UserDto dto) throws SQLException {
        Authentication auth = SecurityContextHolder
                .getContext()
                .getAuthentication();
        UserDetails userDetail = (UserDetails) auth.getPrincipal();
        if (dto.getRoles() == null) {
            throw new SQLException("Campos vacíos", String.valueOf(TypesResponse.ERROR));
        }
        Optional<User> optionalUser = repository.findFirstByEmail(userDetail.getUsername());
        if (!optionalUser.isPresent()) {
            return new ResponseEntity<>(new Message("Usuario no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        if (dto.getRoles().isEmpty()) {
            return new ResponseEntity<>(new Message("No ingresó roles", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        Optional<Role> roleOptional = roleService.findById(dto.getRoles().get(0).getId());
        if (!roleOptional.isPresent()) {
            return new ResponseEntity<>(new Message("Rol no encontrado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        User user = optionalUser.get();
        Optional<User> userOptional = repository.searchUserWithRole("%" + roleOptional.get().getKeyRole() + "%", user.getId());
        if (!userOptional.isPresent()) {
            return new ResponseEntity<>(new Message("Rol no encontrado en el usuario", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        String tkn = jwtProvider.generateToken(auth);
        JwtDto jwtDto = new JwtDto(tkn, userDetail.getUsername(), Collections.singletonList(roleOptional.get()));
        jwtDto.setName(user.getPerson().getName() + " " + user.getPerson().getSurname());
        jwtDto.setIdentKey(user.getPerson().getId());
        return new ResponseEntity<>(jwtDto, HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> save(UserDto dto) throws SQLException {
        /*
        if (dto.getPerson().getName() == null || dto.getPerson().getSurname() == null
                || dto.getPerson().getSex() == null || dto.getPerson().getBirthDate() == null
                || dto.getPerson().getState() == null || dto.getEmail() == null
                || dto.getPerson().getCellphone() == null
        ) {
            throw new SQLException("Campos vacíos", String.valueOf(TypesResponse.ERROR));
        }
         */
        if (!emailValidator.isValid(dto.getEmail())) {
            return new ResponseEntity<>(new Message("Email malformado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }

        Optional<User> optionalUser = repository.findFirstByEmail(dto.getEmail());
        if (optionalUser.isPresent()) {
            return new ResponseEntity<>(new Message("El correo electrónico del usuario ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        if (dto.getRoles().isEmpty()) {
            return new ResponseEntity<>(new Message("No ingresó roles", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        PersonDto personDto = new PersonDto(dto.getPerson());
        ResponseEntity responseEntity = personService.save(personDto);
        Message message = (Message) responseEntity.getBody();
        assert message != null;
        if (!message.getType().equals(TypesResponse.SUCCESS)) {
            return new ResponseEntity<>(new Message(message.getText(), message.getType()), HttpStatus.BAD_REQUEST);
        }
        User user = new User();
        user.asignValuesRegister(dto);
        user.setPassword(passwordEncoder.encode(dto.getEmail()));
        String roles = setRoles(dto.getRoles());
        user.setRoles(roles);
        user.setPerson((Person) message.getResult());
        user.setProfile(dto.getProfile());
        user.setUsername(dto.getUsername());
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("Usuario no registrado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Usuario registrado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> saveClient(UserDto dto) throws SQLException {
        /*
        if (dto.getPerson().getName() == null || dto.getPerson().getSurname() == null
                || dto.getPerson().getSex() == null || dto.getPerson().getBirthDate() == null
                || dto.getPerson().getState() == null || dto.getEmail() == null
                || dto.getPerson().getCellphone() == null
        ) {
            throw new SQLException("Campos vacíos", String.valueOf(TypesResponse.ERROR));
        }

         */
        if (!emailValidator.isValid(dto.getEmail())) {
            return new ResponseEntity<>(new Message("Email malformado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }

        Optional<User> optionalUser = repository.findFirstByEmail(dto.getEmail());
        if (optionalUser.isPresent()) {
            return new ResponseEntity<>(new Message("El correo electrónico del usuario ya existe", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        if (dto.getRoles().isEmpty()) {
            return new ResponseEntity<>(new Message("No ingresó roles", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        if(dto.getPassword() == null || dto.getPassword()==""){
            return new ResponseEntity<>(new Message("No ingresó contraseña", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        PersonDto personDto = new PersonDto(dto.getPerson());



        ResponseEntity responseEntity = personService.save(personDto);
        Message message = (Message) responseEntity.getBody();
        assert message != null;
        if (!message.getType().equals(TypesResponse.SUCCESS)) {
            return new ResponseEntity<>(new Message(message.getText(), message.getType()), HttpStatus.BAD_REQUEST);
        }
        User user = new User();
        user.asignValuesRegister(dto);
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        String roles = setRoles(dto.getRoles());
        user.setRoles(roles);
        user.setPerson((Person) message.getResult());
        user.setProfile(dto.getProfile());
        user.setUsername(dto.getUsername());
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("Usuario no registrado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Usuario registrado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> update(UserDto dto) throws SQLException {
        Optional<User> optionalUser = repository.findById(dto.getId());
        if (!optionalUser.isPresent()) {
            return new ResponseEntity<>(new Message("Usuario no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        User user = optionalUser.get();
        if (dto.getRoles().isEmpty()) {
            return new ResponseEntity<>(new Message("No ingresó roles", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        String roles = setRoles(dto.getRoles());
        dto.getPerson().setId(user.getPerson().getId());
        PersonDto personDto = new PersonDto(dto.getPerson());
        ResponseEntity responseEntity = personService.update(personDto);
        Message message = (Message) responseEntity.getBody();
        assert message != null;
        if (!message.getType().equals(TypesResponse.SUCCESS)) {
            return new ResponseEntity<>(new Message(message.getText(), message.getType()), HttpStatus.BAD_REQUEST);
        }
        if (user.getPassword() == null) {
            user.setChangePassword(false);
            user.setPassword(passwordEncoder.encode(dto.getPassword()));
        }
        user.setRoles(roles);
        user.setProfile(dto.getProfile());
        user.setUsername(dto.getUsername());
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("Usuario no modificado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Usuario modificado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> updateRole(User user) throws JsonProcessingException {
        String roles = setRoles(user.getRoles());
        user.setRoles(roles);
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("Roles de usuario no modificados", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Roles de usuario modificados", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> changeStatus(UserDto dto) throws SQLException {
        Optional<User> optionalUser = repository.findById(dto.getId());
        if (!optionalUser.isPresent()) {
            return new ResponseEntity<>(new Message("Usuario no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        User user = optionalUser.get();
        boolean status = user.isStatus();
        user.setStatus(!status);
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("Estado del usuario no modificado", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Estado del usuario modificado", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(readOnly = true)
    public ResponseEntity<Object> getOne(UserDto dto) {
        Optional<User> optionalUser = repository.findById(dto.getId());
        return optionalUser.<ResponseEntity<Object>>map(user -> new ResponseEntity<>(new Message(user, "Usuario encontrado", TypesResponse.SUCCESS), HttpStatus.OK)).orElseGet(() -> new ResponseEntity<>(new Message("Usuario no encontrado", TypesResponse.WARNING), HttpStatus.NOT_FOUND));
    }

    public String setRoles(List<Role> list) {
        StringBuilder roles = new StringBuilder("[");
        for (Role role : list) {
            Optional<Role> roleOptional = roleService.findById(role.getId());
            if (!roleOptional.isPresent()) {
                continue;
            }
            if (!roleOptional.get().isStatus()) {
                continue;
            }
            roles.append(roleOptional.get()).append(",");
        }
        roles = new StringBuilder(roles.lastIndexOf(",") == roles.length() - 1 ? roles.substring(0, roles.length() - 1) : roles.toString());
        roles.append("]");
        return roles.toString();
    }

    /*****************************************************************************************************************/
    //Acceso
    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> recover(UserDto usuarioDto) {
        Optional<User> usOpt = repository.findFirstByEmail(usuarioDto.getEmail());
        if (!usOpt.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el usuario", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        User user = usOpt.get();
        if (!user.isStatus()) {
            return new ResponseEntity<>(new Message("Usuario inactivo", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        RandomString tickets = new RandomString(5);
        user.setRecuperation(tickets.nextString());
        Date date = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, 1);
        date = calendar.getTime();
        user.setDateExpiration(date);
        repository.saveAndFlush(user);
        emailService.sendSimpleMessage(
                user.getEmail(),
                "ViajaBara | Solicitud de restablecimiento de contraseña",
                "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
                        "<html dir=\"ltr\" xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" lang=\"es\">\n" +
                        " <head>\n" +
                        "  <meta charset=\"UTF-8\">\n" +
                        "  <meta content=\"width=device-width, initial-scale=1\" name=\"viewport\">\n" +
                        "  <meta name=\"x-apple-disable-message-reformatting\">\n" +
                        "  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
                        "  <meta content=\"telephone=no\" name=\"format-detection\">\n" +
                        "  <title>New Template</title><!--[if (mso 16)]>\n" +
                        "    <style type=\"text/css\">\n" +
                        "    a {text-decoration: none;}\n" +
                        "    </style>\n" +
                        "    <![endif]--><!--[if gte mso 9]><style>sup { font-size: 100% !important; }</style><![endif]--><!--[if gte mso 9]>\n" +
                        "<xml>\n" +
                        "    <o:OfficeDocumentSettings>\n" +
                        "    <o:AllowPNG></o:AllowPNG>\n" +
                        "    <o:PixelsPerInch>96</o:PixelsPerInch>\n" +
                        "    </o:OfficeDocumentSettings>\n" +
                        "</xml>\n" +
                        "<![endif]-->\n" +
                        "  <style type=\"text/css\">\n" +
                        ".rollover:hover .rollover-first {\n" +
                        "  max-height:0px!important;\n" +
                        "  display:none!important;\n" +
                        "  }\n" +
                        "  .rollover:hover .rollover-second {\n" +
                        "  max-height:none!important;\n" +
                        "  display:inline-block!important;\n" +
                        "  }\n" +
                        "  .rollover div {\n" +
                        "  font-size:0px;\n" +
                        "  }\n" +
                        "  u + .body img ~ div div {\n" +
                        "  display:none;\n" +
                        "  }\n" +
                        "  #outlook a {\n" +
                        "  padding:0;\n" +
                        "  }\n" +
                        "  span.MsoHyperlink,\n" +
                        "span.MsoHyperlinkFollowed {\n" +
                        "  color:inherit;\n" +
                        "  mso-style-priority:99;\n" +
                        "  }\n" +
                        "  a.es-button {\n" +
                        "  mso-style-priority:100!important;\n" +
                        "  text-decoration:none!important;\n" +
                        "  }\n" +
                        "  a[x-apple-data-detectors] {\n" +
                        "  color:inherit!important;\n" +
                        "  text-decoration:none!important;\n" +
                        "  font-size:inherit!important;\n" +
                        "  font-family:inherit!important;\n" +
                        "  font-weight:inherit!important;\n" +
                        "  line-height:inherit!important;\n" +
                        "  }\n" +
                        "  .es-desk-hidden {\n" +
                        "  display:none;\n" +
                        "  float:left;\n" +
                        "  overflow:hidden;\n" +
                        "  width:0;\n" +
                        "  max-height:0;\n" +
                        "  line-height:0;\n" +
                        "  mso-hide:all;\n" +
                        "  }\n" +
                        "  .es-button-border:hover > a.es-button {\n" +
                        "  color:#ffffff!important;\n" +
                        "  }\n" +
                        "@media only screen and (max-width:600px) {.es-m-p0r { padding-right:0px!important } .es-m-p0l { padding-left:0px!important } *[class=\"gmail-fix\"] { display:none!important } p, a { line-height:150%!important } h1, h1 a { line-height:120%!important } h2, h2 a { line-height:120%!important } h3, h3 a { line-height:120%!important } h4, h4 a { line-height:120%!important } h5, h5 a { line-height:120%!important } h6, h6 a { line-height:120%!important } h1 { font-size:36px!important; text-align:left } h2 { font-size:26px!important; text-align:left } h3 { font-size:20px!important; text-align:left } h4 { font-size:24px!important; text-align:left } h5 { font-size:20px!important; text-align:left } h6 { font-size:16px!important; text-align:left } .es-header-body h1 a, .es-content-body h1 a, .es-footer-body h1 a { font-size:36px!important } .es-header-body h2 a, .es-content-body h2 a, .es-footer-body h2 a { font-size:26px!important } .es-header-body h3 a, .es-content-body h3 a, .es-footer-body h3 a { font-size:20px!important } .es-header-body h4 a, .es-content-body h4 a, .es-footer-body h4 a { font-size:24px!important } .es-header-body h5 a, .es-content-body h5 a, .es-footer-body h5 a { font-size:20px!important } .es-header-body h6 a, .es-content-body h6 a, .es-footer-body h6 a { font-size:16px!important } .es-menu td a { font-size:12px!important } .es-header-body p, .es-header-body a { font-size:14px!important } .es-content-body p, .es-content-body a { font-size:16px!important } .es-footer-body p, .es-footer-body a { font-size:14px!important } .es-infoblock p, .es-infoblock a { font-size:12px!important } .es-m-txt-c, .es-m-txt-c h1, .es-m-txt-c h2, .es-m-txt-c h3, .es-m-txt-c h4, .es-m-txt-c h5, .es-m-txt-c h6 { text-align:center!important } .es-m-txt-r, .es-m-txt-r h1, .es-m-txt-r h2, .es-m-txt-r h3, .es-m-txt-r h4, .es-m-txt-r h5, .es-m-txt-r h6 { text-align:right!important } .es-m-txt-j, .es-m-txt-j h1, .es-m-txt-j h2, .es-m-txt-j h3, .es-m-txt-j h4, .es-m-txt-j h5, .es-m-txt-j h6 { text-align:justify!important } .es-m-txt-l, .es-m-txt-l h1, .es-m-txt-l h2, .es-m-txt-l h3, .es-m-txt-l h4, .es-m-txt-l h5, .es-m-txt-l h6 { text-align:left!important } .es-m-txt-r img, .es-m-txt-c img, .es-m-txt-l img { display:inline!important } .es-m-txt-r .rollover:hover .rollover-second, .es-m-txt-c .rollover:hover .rollover-second, .es-m-txt-l .rollover:hover .rollover-second { display:inline!important } .es-m-txt-r .rollover div, .es-m-txt-c .rollover div, .es-m-txt-l .rollover div { line-height:0!important; font-size:0!important } .es-spacer { display:inline-table } a.es-button, button.es-button { font-size:20px!important; line-height:120%!important } a.es-button, button.es-button, .es-button-border { display:inline-block!important } .es-m-fw, .es-m-fw.es-fw, .es-m-fw .es-button { display:block!important } .es-m-il, .es-m-il .es-button, .es-social, .es-social td, .es-menu { display:inline-block!important } .es-adaptive table, .es-left, .es-right { width:100%!important } .es-content table, .es-header table, .es-footer table, .es-content, .es-footer, .es-header { width:100%!important; max-width:600px!important } .adapt-img { width:100%!important; height:auto!important } .es-mobile-hidden, .es-hidden { display:none!important } .es-desk-hidden { width:auto!important; overflow:visible!important; float:none!important; max-height:inherit!important; line-height:inherit!important } tr.es-desk-hidden { display:table-row!important } table.es-desk-hidden { display:table!important } td.es-desk-menu-hidden { display:table-cell!important } .es-menu td { width:1%!important } table.es-table-not-adapt, .esd-block-html table { width:auto!important } .es-social td { padding-bottom:10px } .h-auto { height:auto!important } }\n" +
                        "</style>\n" +
                        " </head>\n" +
                        " <body class=\"body\" style=\"width:100%;height:100%;padding:0;Margin:0\">\n" +
                        "  <div dir=\"ltr\" class=\"es-wrapper-color\" lang=\"es\" style=\"background-color:#FAFAFA\"><!--[if gte mso 9]>\n" +
                        "\t\t\t<v:background xmlns:v=\"urn:schemas-microsoft-com:vml\" fill=\"t\">\n" +
                        "\t\t\t\t<v:fill type=\"tile\" color=\"#fafafa\"></v:fill>\n" +
                        "\t\t\t</v:background>\n" +
                        "\t\t<![endif]-->\n" +
                        "   <table class=\"es-wrapper\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;padding:0;Margin:0;width:100%;height:100%;background-repeat:repeat;background-position:center top;background-color:#FAFAFA\">\n" +
                        "     <tr>\n" +
                        "      <td valign=\"top\" style=\"padding:0;Margin:0\">\n" +
                        "       <table cellpadding=\"0\" cellspacing=\"0\" class=\"es-content\" align=\"center\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;table-layout:fixed !important\">\n" +
                        "         <tr>\n" +
                        "          <td class=\"es-info-area\" align=\"center\" style=\"padding:0;Margin:0\">\n" +
                        "           <table class=\"es-content-body\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:transparent;width:600px\" bgcolor=\"#FFFFFF\" role=\"none\">\n" +
                        "             <tr>\n" +
                        "              <td align=\"left\" style=\"padding:20px;Margin:0\">\n" +
                        "               <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "                 <tr>\n" +
                        "                  <td align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;width:560px\">\n" +
                        "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" role=\"presentation\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "      \n" +
                        "                   </table></td>\n" +
                        "                 </tr>\n" +
                        "               </table></td>\n" +
                        "             </tr>\n" +
                        "           </table></td>\n" +
                        "         </tr>\n" +
                        "       </table>\n" +
                        "       <table cellpadding=\"0\" cellspacing=\"0\" class=\"es-content\" align=\"center\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;table-layout:fixed !important\">\n" +
                        "         <tr>\n" +
                        "          <td align=\"center\" style=\"padding:0;Margin:0\">\n" +
                        "           <table bgcolor=\"#ffffff\" class=\"es-content-body\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:#FFFFFF;width:600px\">\n" +
                        "             <tr>\n" +
                        "              <td align=\"left\" style=\"Margin:0;padding-top:30px;padding-right:20px;padding-bottom:10px;padding-left:20px\">\n" +
                        "               <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "                 <tr>\n" +
                        "                  <td align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;width:560px\">\n" +
                        "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" role=\"presentation\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "                     <tr>\n" +
                        "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:10px;padding-top:10px;font-size:0px\"><img src=\"https://ebhhboq.stripocdn.email/content/guids/CABINET_cd4034a93651821470fff1e87c9e09a3dd1056ef876f8f14ad6ab7fcce3d45c5/images/candado.png\" alt=\"\" style=\"display:block;font-size:14px;border:0;outline:none;text-decoration:none\" width=\"75\"></td>\n" +
                        "                     </tr>\n" +
                        "                     <tr>\n" +
                        "                      <td align=\"center\" class=\"es-m-txt-c\" style=\"padding:0;Margin:0;padding-bottom:10px\"><h2 style=\"Margin:0;font-family:arial, 'helvetica neue', helvetica, sans-serif;mso-line-height-rule:exactly;letter-spacing:0;font-size:26px;font-style:normal;font-weight:bold;line-height:31px;color:#333333\"><b>Restablecimiento de contraseña</b></h2></td>\n" +
                        "                     </tr>\n" +
                        "                     <tr>\n" +
                        "                      <td align=\"center\" class=\"es-m-p0r es-m-p0l\" style=\"Margin:0;padding-top:5px;padding-right:40px;padding-bottom:5px;padding-left:40px\"><p style=\"Margin:0;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;letter-spacing:0;color:#333333;font-size:14px\">Para restablecer la contraseña debes ingresar el código en la página que lo solicita.</p><p style=\"Margin:0;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:21px;letter-spacing:0;color:#333333;font-size:14px\">\u200B<strong>Nota: El código proporcionado tiene una validez de 24 horas.</strong></p><br></td>\n" +
                        "                     </tr>\n" +
                        "                   </table></td>\n" +
                        "                 </tr>\n" +
                        "               </table></td>\n" +
                        "             </tr>\n" +
                        "             <tr>\n" +
                        "              <td align=\"left\" style=\"Margin:0;padding-right:20px;padding-bottom:10px;padding-left:20px;padding-top:10px\">\n" +
                        "               <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "                 <tr>\n" +
                        "                  <td align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;width:560px\">\n" +
                        "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:separate;border-spacing:0px;border-left:2px dashed #cccccc;border-right:2px dashed #cccccc;border-top:2px dashed #cccccc;border-bottom:2px dashed #cccccc;border-radius:5px\" role=\"presentation\">\n" +
                        "                     <tr>\n" +
                        "                      <td align=\"center\" class=\"es-m-txt-c\" style=\"padding:0;Margin:0;padding-right:20px;padding-left:20px;padding-top:20px\"><h2 style=\"Margin:0;font-family:arial, 'helvetica neue', helvetica, sans-serif;mso-line-height-rule:exactly;letter-spacing:0;font-size:26px;font-style:normal;font-weight:bold;line-height:31px;color:#333333\">Código</h2></td>\n" +
                        "                     </tr>\n" +
                        "                     <tr>\n" +
                        "                      <td align=\"center\" class=\"es-m-txt-c\" style=\"Margin:0;padding-right:20px;padding-left:20px;padding-top:10px;padding-bottom:20px\"><h1 style=\"Margin:0;font-family:arial, 'helvetica neue', helvetica, sans-serif;mso-line-height-rule:exactly;letter-spacing:0;font-size:46px;font-style:normal;font-weight:bold;line-height:55px;color:#5c68e2\"><strong>"+ user.getRecuperation() +"</strong></h1></td>\n" +
                        "                     </tr>\n" +
                        "                   </table></td>\n" +
                        "                 </tr>\n" +
                        "               </table></td>\n" +
                        "             </tr>\n" +
                        "             <tr>\n" +
                        "              <td align=\"left\" style=\"padding:0;Margin:0;padding-right:20px;padding-left:20px;padding-bottom:30px\">\n" +
                        "               <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "                 <tr>\n" +
                        "                  <td align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;width:560px\">\n" +
                        "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:separate;border-spacing:0px;border-radius:5px\" role=\"none\">\n" +
                        "                     <tr>\n" +
                        "                      <td align=\"center\" style=\"padding:0;Margin:0;display:none\"></td>\n" +
                        "                     </tr>\n" +
                        "                   </table></td>\n" +
                        "                 </tr>\n" +
                        "               </table></td>\n" +
                        "             </tr>\n" +
                        "           </table></td>\n" +
                        "         </tr>\n" +
                        "       </table>\n" +
                        "       <table cellpadding=\"0\" cellspacing=\"0\" class=\"es-footer\" align=\"center\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;width:100%;table-layout:fixed !important;background-color:transparent;background-repeat:repeat;background-position:center top\">\n" +
                        "         <tr>\n" +
                        "          <td align=\"center\" style=\"padding:0;Margin:0\">\n" +
                        "           <table class=\"es-footer-body\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px;background-color:transparent;width:640px\" role=\"none\">\n" +
                        "             <tr>\n" +
                        "              <td align=\"left\" style=\"Margin:0;padding-right:20px;padding-left:20px;padding-top:20px;padding-bottom:20px\">\n" +
                        "               <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" role=\"none\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "                 <tr>\n" +
                        "                  <td align=\"left\" style=\"padding:0;Margin:0;width:600px\">\n" +
                        "                   <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" role=\"presentation\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "                     <tr>\n" +
                        "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-top:15px;padding-bottom:15px;font-size:0\">\n" +
                        "                       <table cellpadding=\"0\" cellspacing=\"0\" class=\"es-table-not-adapt es-social\" role=\"presentation\" style=\"mso-table-lspace:0pt;mso-table-rspace:0pt;border-collapse:collapse;border-spacing:0px\">\n" +
                        "                         <tr>\n" +
                        "                          <td align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;padding-right:40px\"><img title=\"Facebook\" src=\"https://ebhhboq.stripocdn.email/content/assets/img/social-icons/logo-black/facebook-logo-black.png\" alt=\"Fb\" width=\"32\" style=\"display:block;font-size:14px;border:0;outline:none;text-decoration:none\"></td>\n" +
                        "                          <td align=\"center\" valign=\"top\" style=\"padding:0;Margin:0;padding-right:40px\"><img title=\"X.com\" src=\"https://ebhhboq.stripocdn.email/content/assets/img/social-icons/logo-black/x-logo-black.png\" alt=\"X\" width=\"32\" style=\"display:block;font-size:14px;border:0;outline:none;text-decoration:none\"></td>\n" +
                        "                          <td align=\"center\" valign=\"top\" style=\"padding:0;Margin:0\"><img title=\"Instagram\" src=\"https://ebhhboq.stripocdn.email/content/assets/img/social-icons/logo-black/instagram-logo-black.png\" alt=\"Inst\" width=\"32\" style=\"display:block;font-size:14px;border:0;outline:none;text-decoration:none\"></td>\n" +
                        "                         </tr>\n" +
                        "                       </table></td>\n" +
                        "                     </tr>\n" +
                        "                     <tr>\n" +
                        "                      <td align=\"center\" style=\"padding:0;Margin:0;padding-bottom:35px\"><p style=\"Margin:0;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:18px;letter-spacing:0;color:#333333;font-size:12px\">ViajaBara © 2023.. Todos los derechos reservados.</p><p style=\"Margin:0;mso-line-height-rule:exactly;font-family:arial, 'helvetica neue', helvetica, sans-serif;line-height:18px;letter-spacing:0;color:#333333;font-size:12px\">\u200B</p></td>\n" +
                        "                     </tr>\n" +
                        "                   </table></td>\n" +
                        "                 </tr>\n" +
                        "               </table></td>\n" +
                        "             </tr>\n" +
                        "           </table></td>\n" +
                        "         </tr>\n" +
                        "       </table></td>\n" +
                        "     </tr>\n" +
                        "   </table>\n" +
                        "  </div>\n" +
                        " </body>\n" +
                        "</html>");
        return new ResponseEntity<>(new Message(user, "Correo enviado", TypesResponse.SUCCESS), HttpStatus.OK);

    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> verifyCode(UserDto dto) {
        Optional<User> usOpt = repository.findFirstByEmail(dto.getEmail());
        if (!usOpt.isPresent()) {
            return new ResponseEntity<>(new Message("Ocurrió un TypesResponse.ERROR", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        if (!usOpt.get().isStatus()) {
            return new ResponseEntity<>(new Message("Usuario inhabilitado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        User user = usOpt.get();
        if (!dto.getRecuperation().equals(user.getRecuperation())) {
            return new ResponseEntity<>(new Message("El código no coincide con el que fue enviado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        if (user.getDateExpiration().before(new Date())) {
            user.setRecuperation(null);
            user.setDateExpiration(null);
            repository.saveAndFlush(user);
            return new ResponseEntity<>(new Message("Código caducado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Código válido", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> updatePassword(UserDto dto) {
        Optional<User> usOpt = repository.findFirstByEmail(dto.getEmail());
        if (!usOpt.isPresent()) {
            return new ResponseEntity<>(new Message("Falló el restablecimiento de contraseña", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        if (this.verifyCode(dto).getStatusCodeValue() != 200) {
            return new ResponseEntity<>(new Message("Ocurrió un problema con el código", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        if (passwordEncoder.matches(dto.getPassword(), usOpt.get().getPassword())) {
            return new ResponseEntity<>(new Message("La nueva contraseña no puede ser igual a la actual", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        boolean valid = passwordValidator.isValid(dto.getPassword());
        if (!valid) {
            return new ResponseEntity<>(new Message("La contraseña no cumple con las características de contraseña segura", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        User user = usOpt.get();
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setChangePassword(false);
        user.setRecuperation(null);
        user.setDateExpiration(null);
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("No se modificó la contraseña", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Contraseña modificada", TypesResponse.SUCCESS), HttpStatus.OK);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public ResponseEntity<Object> restorePassword(UserDto dto) {
        Optional<User> usOpt = repository.findById(dto.getId());
        if (!usOpt.isPresent()) {
            return new ResponseEntity<>(new Message("No se encontró el usuario", TypesResponse.WARNING), HttpStatus.NOT_FOUND);
        }
        if (!usOpt.get().isStatus()) {
            return new ResponseEntity<>(new Message("El usuario está inhabilitado", TypesResponse.WARNING), HttpStatus.BAD_REQUEST);
        }
        User user = usOpt.get();
        user.setPassword(passwordEncoder.encode(user.getEmail()));
        user.setChangePassword(true);
        user = repository.saveAndFlush(user);
        if (user == null) {
            return new ResponseEntity<>(new Message("No se modificó la contraseña", TypesResponse.ERROR), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(new Message(user, "Contraseña restablecida", TypesResponse.SUCCESS), HttpStatus.OK);
    }


    @Transactional(rollbackFor = {SQLException.class})
    public void setAttempts(Long id) {
        Optional<User> optionalUser = repository.findById(id);
        if (!optionalUser.isPresent()) {
            return;
        }
        User user = optionalUser.get();
        user.setAttempts(user.getAttempts() + 1);
        if (user.getAttempts() >= 4) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            user.setTimeBlocked(calendar.getTime());
        }
        user = repository.saveAndFlush(user);
    }

    @Transactional(rollbackFor = {SQLException.class})
    public boolean restore(Long id) {
        Optional<User> optionalUser = repository.findById(id);
        if (!optionalUser.isPresent()) {
            return false;
        }
        User user = optionalUser.get();
        user.setAttempts(0);
        user.setTimeBlocked(null);
        user.setStatus(true);
        user = repository.saveAndFlush(user);
        return (user == null);
    }

}