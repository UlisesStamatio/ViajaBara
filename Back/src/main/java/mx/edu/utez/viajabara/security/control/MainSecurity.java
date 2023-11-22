package mx.edu.utez.viajabara.security.control;

import mx.edu.utez.viajabara.access.privilege.model.PrivilegeName;
import mx.edu.utez.viajabara.security.jwt.JwtEntryPoint;
import mx.edu.utez.viajabara.security.jwt.JwtTokenFilter;
import mx.edu.utez.viajabara.security.service.MyUserDetailsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class MainSecurity extends WebSecurityConfigurerAdapter {
    private final static Logger logger = LoggerFactory.getLogger(MainSecurity.class);
    @Autowired
    MyUserDetailsService userDetailsService;

    @Autowired
    JwtEntryPoint entryPoint;

    private static final String[] AUTH_WHITELIST = {
            "/swagger-resources/**",
            "/swagger-ui.html",
            "/v2/api-docs",
            "/webjars/**"
    };

    @Bean
    public JwtTokenFilter jwtTokenFilter() {
        return new JwtTokenFilter();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected AuthenticationManager authenticationManager() throws Exception {
        return super.authenticationManager();
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().and().csrf().disable()
                .authorizeHttpRequests(authorize -> authorize
                        .antMatchers("/api/role/**").hasAuthority(PrivilegeName.ROLES.name())
                        .antMatchers("/api/privilege/**").hasAuthority(PrivilegeName.PRIVILEGIOS.name())
                        .antMatchers("/api/user/**").hasAuthority(PrivilegeName.USUARIOS.name())
                        .antMatchers("/api/visual-config/**").hasAuthority(PrivilegeName.CONFIGURACIONES_VISUALES.name())
                        .antMatchers("/api/state/**").hasAuthority(PrivilegeName.ESTADOS.name())
                        .antMatchers("/api/duties/**").hasAuthority(PrivilegeName.SERVICIOS.name())
                        .antMatchers("/api/buses/**").hasAuthority(PrivilegeName.AUTOBUSES.name())
                        .antMatchers("/api/routes/**").hasAuthority(PrivilegeName.RUTAS.name())
                        .antMatchers("/api/trips/**").hasAuthority(PrivilegeName.VIAJES.name())
                        .antMatchers("/api/open-trips/**").hasAuthority(PrivilegeName.VIAJES_ABIERTOS.name())
                        .antMatchers("/api/seating-sales/**").hasAuthority(PrivilegeName.VENTA_ASIENTOS.name())
                        .antMatchers("/api/qualifications/**").hasAuthority(PrivilegeName.CALIFICACIONES.name())
                        .antMatchers("/api/driver/**").hasAuthority(PrivilegeName.CONDUCTOR.name())
                        .antMatchers("/api/client/**").hasAuthority(PrivilegeName.CLIENTE.name())
                        .antMatchers("/api/logged/**").authenticated()
                        .antMatchers("/api/lists/**").permitAll()
                        .antMatchers("/api/general/**").permitAll()
                        .antMatchers("/api/captcha/**").permitAll()


                        .antMatchers("/api/auth/**", "/swagger-ui").permitAll()
                        .antMatchers(AUTH_WHITELIST).permitAll()
                        .antMatchers("/api/**").authenticated())
                .logout().clearAuthentication(true)
                .invalidateHttpSession(true)
                .clearAuthentication(true).deleteCookies("JSESSIONID")
                .permitAll().and().exceptionHandling()
                .authenticationEntryPoint(entryPoint)
                .and().sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        logger.info("Configuramos el filtro");
        http.addFilterBefore(jwtTokenFilter(), UsernamePasswordAuthenticationFilter.class);
    }
}
