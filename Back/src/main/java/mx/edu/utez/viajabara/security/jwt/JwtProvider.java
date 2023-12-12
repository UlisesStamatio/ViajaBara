package mx.edu.utez.viajabara.security.jwt;

import io.jsonwebtoken.*;
import mx.edu.utez.viajabara.security.entity.MyUserDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class JwtProvider {
    private final static Logger logger = LoggerFactory.getLogger(JwtProvider.class);
    @Value("${jwt.secret}")
    private String secret;
    @Value("${jwt.expiration}")
    private int expiration;

    public String generateToken(Authentication authentication) {
        MyUserDetails userDetails = (MyUserDetails) authentication.getPrincipal();
        return Jwts.builder()
                .setSubject(userDetails.getUsername()).setIssuedAt(new Date())
                .setExpiration(new Date(new Date().getTime() + expiration * 1000L))
                .signWith(SignatureAlgorithm.HS512, secret).compact();
    }

    public String getUsernameFromToken(String token) {
        return Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody().getSubject();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(secret).parseClaimsJws(token);
            return true;
        } catch (MalformedJwtException e) {
            logger.error("Token mal formado");
            throw e;
        } catch (UnsupportedJwtException e) {
            logger.error("Token no soportado");
            throw e;
        } catch (ExpiredJwtException e) {
            logger.error("Token expirado");
            throw e;
        } catch (IllegalArgumentException e) {
            logger.error("Token vacío");
            throw e;
        } catch (SignatureException e) {
            logger.error("Firma erronea");
            throw e;
        }
    }
}
