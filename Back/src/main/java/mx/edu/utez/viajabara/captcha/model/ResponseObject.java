package mx.edu.utez.viajabara.captcha.model;
import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

/**
 * The Class ResponseObject.
 */
@JsonIgnoreProperties(ignoreUnknown = true)
@JsonInclude(Include.NON_NULL)
public class ResponseObject implements Serializable {

    /**
     * The Constant serialVersionUID.
     */
    private static final long serialVersionUID = 1L;

    private String token;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @Override
    public String toString() {
        return "ResponseObject [token=" + token + "]";
    }

}