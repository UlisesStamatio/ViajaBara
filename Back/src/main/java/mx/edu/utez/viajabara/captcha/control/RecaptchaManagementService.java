package mx.edu.utez.viajabara.captcha.control;
import javax.validation.ValidationException;

import mx.edu.utez.viajabara.captcha.model.RecaptchaResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Component
public class RecaptchaManagementService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RecaptchaManagementService.class);

    public RecaptchaManagementService() {
        super();
    }

    @Value("${google.recaptcha.secret}")
    String secret;
    public @ResponseBody Boolean validateCaptcha2(String captchaResponse) throws ValidationException{
        String url = "https://www.google.com/recaptcha/api/siteverify";
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap <String,String>requestMap = new LinkedMultiValueMap<>();
        requestMap.add("secret",secret);
        requestMap.add("response",captchaResponse);
        RecaptchaResponse rs = restTemplate.postForObject(url,requestMap,RecaptchaResponse.class);
        if(rs==null){
            return false;
        }
        return Boolean.TRUE.equals(rs.isSuccess());
    }
}