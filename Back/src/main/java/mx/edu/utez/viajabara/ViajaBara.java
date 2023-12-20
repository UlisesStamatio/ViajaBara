package mx.edu.utez.viajabara;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import javax.annotation.PostConstruct;
import java.util.TimeZone;

@EnableWebMvc
@EnableSwagger2
@SpringBootApplication
public class ViajaBara {
    public static void main(String[] args) {
        SpringApplication.run(ViajaBara.class, args);
    }

    @PostConstruct
    void started() {
        // Configura la zona horaria al iniciar la aplicación
        TimeZone.setDefault(TimeZone.getTimeZone("America/Mexico_City"));
    }
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            public void addCorsMapping(CorsRegistry registry) {
                registry.addMapping("/api/*").allowedOrigins(new String[]{"*"}).allowedMethods();
            }
        };
    }
}
