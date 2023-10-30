package mx.edu.utez.viajabara.security.util;

import mx.edu.utez.viajabara.access.privilege.control.PrivilegeService;
import mx.edu.utez.viajabara.access.privilege.model.Privilege;
import mx.edu.utez.viajabara.access.privilege.model.PrivilegeName;
import mx.edu.utez.viajabara.access.role.control.RoleService;
import mx.edu.utez.viajabara.access.role.model.Role;
import mx.edu.utez.viajabara.access.user.control.UserService;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.access.visualconfig.control.VisualConfigService;
import mx.edu.utez.viajabara.access.visualconfig.model.VisualConfig;
import mx.edu.utez.viajabara.basecatalog.person.control.PersonService;
import mx.edu.utez.viajabara.basecatalog.person.model.Person;
import mx.edu.utez.viajabara.basecatalog.state.control.StateService;
import mx.edu.utez.viajabara.basecatalog.state.model.State;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Component
public class InitialDatabase implements CommandLineRunner {
    private final static Logger logger = LoggerFactory.getLogger(InitialDatabase.class);
    private final PrivilegeService privilegeService;

    private final RoleService roleService;

    private final UserService userService;

    private final StateService stateService;

    private final PasswordEncoder passwordEncoder;

    private final VisualConfigService visualConfigService;

    private final PersonService personService;
    @Autowired
    public InitialDatabase(PrivilegeService privilegeService, RoleService roleService, UserService userService, StateService stateService, PasswordEncoder passwordEncoder, VisualConfigService visualConfigService, PersonService personService) {
        this.privilegeService = privilegeService;
        this.roleService = roleService;
        this.userService = userService;
        this.stateService = stateService;
        this.passwordEncoder = passwordEncoder;
        this.visualConfigService = visualConfigService;
        this.personService = personService;
    }

    @Override
    public void run(String... args){
        /* PRIVILEGIOS */
        /*CONTROL DE ACCESO*/
        Privilege privilege;
        String privilegesCA = "[";

        Optional<Privilege> optionalPrivilege = privilegeService.findByName(PrivilegeName.USUARIOS);
        if (!optionalPrivilege.isPresent()) {
            privilege = new Privilege(PrivilegeName.USUARIOS,
                    "Catálogo que permite tener el control de todos aquellos " +
                            "usuarios que pueden acceder al sistema");
            privilege = privilegeService.saveInitial(privilege);
        } else {
            privilege = optionalPrivilege.get();
        }
        privilegesCA += privilege.toString() + ",";

        optionalPrivilege = privilegeService.findByName(PrivilegeName.ROLES);
        if (!optionalPrivilege.isPresent()) {
            privilege = new Privilege(PrivilegeName.ROLES,
                    "Catálogo que permite tener el control de todos aquellos " +
                            "rolesCA que pueden permitir el acceso a funcionalidades del sistema");
            privilege = privilegeService.saveInitial(privilege);
        } else {
            privilege = optionalPrivilege.get();
        }
        privilegesCA += privilege.toString() + ",";

        optionalPrivilege = privilegeService.findByName(PrivilegeName.ESTADOS);
        if (!optionalPrivilege.isPresent()) {
            privilege = new Privilege(PrivilegeName.ESTADOS,
                    "Catálogo que permite tener el control de todos aquellos " +
                            "estados de recidencia de los usuarios");
            privilege = privilegeService.saveInitial(privilege);
        } else {
            privilege = optionalPrivilege.get();
        }
        privilegesCA += privilege.toString() + ",";

        optionalPrivilege = privilegeService.findByName(PrivilegeName.PRIVILEGIOS);
        if (!optionalPrivilege.isPresent()) {
            privilege = new Privilege(PrivilegeName.PRIVILEGIOS,
                    "Módulos a los que pueden acceder los usuarios");
            privilege = privilegeService.saveInitial(privilege);
        } else {
            privilege = optionalPrivilege.get();
        }
        privilegesCA += privilege.toString() + ",";

        optionalPrivilege = privilegeService.findByName(PrivilegeName.CONFIGURACIONES_VISUALES);
        if (!optionalPrivilege.isPresent()) {
            privilege = new Privilege(PrivilegeName.CONFIGURACIONES_VISUALES,
                    "Catálogo que permite tener el control de todas aquellas " +
                            "configuraciones visuales");
            privilege = privilegeService.saveInitial(privilege);
        }else{
            privilege = optionalPrivilege.get();
        }
        privilegesCA += privilege.toString() + "]";

        String privilegesCK = "[";
        optionalPrivilege = privilegeService.findByName(PrivilegeName.CONDUCTOR);
        if (!optionalPrivilege.isPresent()) {
            privilege = new Privilege(PrivilegeName.CONDUCTOR,
                    "Módulo dedicado para la gestión de las necesidades de un conductor");
            privilege = privilegeService.saveInitial(privilege);
        } else {
            privilege = optionalPrivilege.get();
        }
        privilegesCK += privilege.toString() + "]";


        String privilegesClient = "[";
        optionalPrivilege = privilegeService.findByName(PrivilegeName.CLIENTE);
        if (!optionalPrivilege.isPresent()) {
            privilege = new Privilege(PrivilegeName.CLIENTE,
                    "Módulo dedicado para la gestión de las necesidades de un cliente");
            privilege = privilegeService.saveInitial(privilege);
        } else {
            privilege = optionalPrivilege.get();
        }
        privilegesClient += privilege.toString() + "]";

        /*CATÁLOGO BASE*/

        /* ROLES */
        String rolesCA = "[";
        Optional<Role> roleAdmin = roleService.findByKeyRole("ADMIN");
        Role role = (!roleAdmin.isPresent()) ?
                roleService.saveInitial(new Role("ADMINISTRACIÓN", "ADMIN", privilegesCA, true))
                :
                roleAdmin.get();
        rolesCA += role.toString() + "]";

        String rolesCK = "[";
        Optional<Role> roleChecker = roleService.findByKeyRole("COND");
         role = (!roleChecker.isPresent()) ?
                roleService.saveInitial(new Role("CONDUCTOR", "COND", privilegesCK, true))
                :
                roleChecker.get();
        rolesCK += role.toString() + "]";

        String rolesClient = "[";
        Optional<Role> roleClient = roleService.findByKeyRole("CLIEN");
        role = (!roleClient.isPresent()) ?
                roleService.saveInitial(new Role("CLIENTE", "CLIEN", privilegesClient, true))
                :
                roleClient.get();
        rolesClient += role.toString() + "]";

        /* USUARIO ROOT */
        if (!userService.existsByMail("20203tn159@utez.edu.mx")) {
            Person person;
            Optional<Person> optionalPerson = personService.findByName("ROOT");
            if (optionalPerson.isPresent()) {
                person = optionalPerson.get();
            } else {
                person = new Person("ROOT", "ROOT", "0000000000", "M", new Date(), true);
                person = personService.saveInitialPerson(person);
            }
            User user = new User("PHN2ZyB2aWV3Qm94PSIwIDAgMzYgMzYiIGZpbGw9Im5vbmUiIHJvbGU9ImltZyIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMTIwIiBoZWlnaHQ9IjEyMCI+PG1hc2sgaWQ9Im1hc2tfX2JlYW0iIG1hc2tVbml0cz0idXNlclNwYWNlT25Vc2UiIHg9IjAiIHk9IjAiIHdpZHRoPSIzNiIgaGVpZ2h0PSIzNiI+PHJlY3Qgd2lkdGg9IjM2IiBoZWlnaHQ9IjM2IiByeD0iNzIiIGZpbGw9IiNGRkZGRkYiPjwvcmVjdD48L21hc2s+PGcgbWFzaz0idXJsKCNtYXNrX19iZWFtKSI+PHJlY3Qgd2lkdGg9IjM2IiBoZWlnaHQ9IjM2IiBmaWxsPSIjQzIwRDkwIj48L3JlY3Q+PHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjM2IiBoZWlnaHQ9IjM2IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1IDUpIHJvdGF0ZSgxOTEgMTggMTgpIHNjYWxlKDEuMikiIGZpbGw9IiMxNDZBN0MiIHJ4PSI2Ij48L3JlY3Q+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoNyAzKSByb3RhdGUoMSAxOCAxOCkiPjxwYXRoIGQ9Ik0xMywyMSBhMSwwLjc1IDAgMCwwIDEwLDAiIGZpbGw9IiNGRkZGRkYiPjwvcGF0aD48cmVjdCB4PSIxMyIgeT0iMTQiIHdpZHRoPSIxLjUiIGhlaWdodD0iMiIgcng9IjEiIHN0cm9rZT0ibm9uZSIgZmlsbD0iI0ZGRkZGRiI+PC9yZWN0PjxyZWN0IHg9IjIxIiB5PSIxNCIgd2lkdGg9IjEuNSIgaGVpZ2h0PSIyIiByeD0iMSIgc3Ryb2tlPSJub25lIiBmaWxsPSIjRkZGRkZGIj48L3JlY3Q+PC9nPjwvZz48L3N2Zz4=\n"
                    ,"UsuarioP","20203tn159@utez.edu.mx", passwordEncoder.encode("Admin123"), person, rolesCA, true);
            user.setChangePassword(false);
            user.setPerson(person);
            userService.saveInitialUser(user);
        }
        /* CA */
        /* ESTADOS */
        State state = null;
        VisualConfig visualConfig;

        Optional<State> optionalState = stateService.findByName("AGUASCALIENTES".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("AGUASCALIENTES".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("BAJA CALIFORNIA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("BAJA CALIFORNIA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("BAJA CALIFORNIA SUR".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("BAJA CALIFORNIA SUR".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("CAMPECHE".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("CAMPECHE".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("COAHUILA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("COAHUILA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("COLIMA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("COLIMA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("CHIAPAS".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("CHIAPAS".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("CHIHUAHUA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("CHIHUAHUA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("CIUDAD DE MÉXICO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("CIUDAD DE MÉXICO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("DURANGO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("DURANGO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("GUANAJUATO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("GUANAJUATO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("GUERRERO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("GUERRERO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("HIDALGO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("HIDALGO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("JALISCO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("JALISCO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("MÉXICO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("MÉXICO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("MICHOACÁN".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("MICHOACÁN".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("MORELOS".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("MORELOS".toLowerCase(), true);
            state = stateService.saveInitialState(state);
        }


        optionalState = stateService.findByName("NAYARIT".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("NAYARIT".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("NUEVO LEÓN".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("NUEVO LEÓN".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("OAXACA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("OAXACA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("PUEBLA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("PUEBLA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("QUERÉTARO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("QUERÉTARO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("QUINTANA ROO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("QUINTANA ROO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("SAN LUIS POTOSÍ".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("SAN LUIS POTOSÍ".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("SINALOA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("SINALOA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("SONORA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("SONORA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("TABASCO".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("TABASCO".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("TAMAULIPAS".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("TAMAULIPAS".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("TLAXCALA".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("TLAXCALA".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("VERACRUZ".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("VERACRUZ".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("YUCATÁN".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("YUCATÁN".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        optionalState = stateService.findByName("ZACATECAS".toLowerCase());
        if (!optionalState.isPresent()) {
            state = new State("ZACATECAS".toLowerCase(), true);
            stateService.saveInitialState(state);
        }

        if(visualConfigService.exists()){
            visualConfig = new VisualConfig("#9a1734","#ffffff",
                    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAAA8CAYAAACQPx/OAAAACXBIWXMAAD2EAAA9hAHVrK90AAA4IWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwNjcgNzkuMTU3NzQ3LCAyMDE1LzAzLzMwLTIzOjQwOjQyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIgogICAgICAgICAgICB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIKICAgICAgICAgICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFkb2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNSAoV2luZG93cyk8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHhtcDpDcmVhdGVEYXRlPjIwMTktMDctMDFUMDk6NTUtMDU6MDA8L3htcDpDcmVhdGVEYXRlPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxOS0wNy0wMVQwOTo1NTo1MS0wNTowMDwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6TWV0YWRhdGFEYXRlPjIwMTktMDctMDFUMDk6NTU6NTEtMDU6MDA8L3htcDpNZXRhZGF0YURhdGU+CiAgICAgICAgIDxkYzpmb3JtYXQ+aW1hZ2UvcG5nPC9kYzpmb3JtYXQ+CiAgICAgICAgIDxwaG90b3Nob3A6Q29sb3JNb2RlPjM8L3Bob3Rvc2hvcDpDb2xvck1vZGU+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6MjdjOGNmYmUtMjU5NC0zNzQ1LWFhZjQtNDA5NDcwZDRkNWVhPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06RG9jdW1lbnRJRD54bXAuZGlkOjI3YzhjZmJlLTI1OTQtMzc0NS1hYWY0LTQwOTQ3MGQ0ZDVlYTwveG1wTU06RG9jdW1lbnRJRD4KICAgICAgICAgPHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD54bXAuZGlkOjI3YzhjZmJlLTI1OTQtMzc0NS1hYWY0LTQwOTQ3MGQ0ZDVlYTwveG1wTU06T3JpZ2luYWxEb2N1bWVudElEPgogICAgICAgICA8eG1wTU06SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNyZWF0ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDoyN2M4Y2ZiZS0yNTk0LTM3NDUtYWFmNC00MDk0NzBkNGQ1ZWE8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTktMDctMDFUMDk6NTUtMDU6MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hvcCBDQyAyMDE1IChXaW5kb3dzKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICAgICA8dGlmZjpYUmVzb2x1dGlvbj40MDAwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj40MDAwMDAwLzEwMDAwPC90aWZmOllSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpSZXNvbHV0aW9uVW5pdD4yPC90aWZmOlJlc29sdXRpb25Vbml0PgogICAgICAgICA8ZXhpZjpDb2xvclNwYWNlPjY1NTM1PC9leGlmOkNvbG9yU3BhY2U+CiAgICAgICAgIDxleGlmOlBpeGVsWERpbWVuc2lvbj4xMDA8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogICAgICAgICA8ZXhpZjpQaXhlbFlEaW1lbnNpb24+NjA8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAg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"
                    ,200.52,true);
            visualConfigService.saveInitialState(visualConfig);
        }
    }
}