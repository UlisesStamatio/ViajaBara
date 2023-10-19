package mx.edu.utez.viajabara.captcha.control;
import io.swagger.annotations.Api;
import mx.edu.utez.viajabara.captcha.model.SignupModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/captcha")
@Api(tags = "Captcha")
@CrossOrigin(origins = {"*"}, methods = { RequestMethod.GET,RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
public class RecaptchaManagementController {

    private final RecaptchaManagementService recaptchaManagementService;

    @Autowired
    public RecaptchaManagementController(RecaptchaManagementService recaptchaManagementService) {
        this.recaptchaManagementService = recaptchaManagementService;
    }

    @PostMapping(value = "/validation")
    public @ResponseBody Boolean register2(@RequestBody SignupModel signupModel) {
        return recaptchaManagementService.validateCaptcha2(signupModel.getCaptchaToken());
    }
}