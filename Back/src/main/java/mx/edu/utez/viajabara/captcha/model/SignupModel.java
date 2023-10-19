package mx.edu.utez.viajabara.captcha.model;

public class SignupModel {

    private String captchaToken;

    public SignupModel() {
        super();
    }

    public String getCaptchaToken() {
        return captchaToken;
    }

    public void setCaptchaToken(String captchaToken) {
        this.captchaToken = captchaToken;
    }

    @Override
    public String toString() {
        return "SignupModel [captchaToken=" + captchaToken + "]";
    }

}