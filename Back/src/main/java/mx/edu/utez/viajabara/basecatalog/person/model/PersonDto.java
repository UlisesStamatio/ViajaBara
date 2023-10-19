package mx.edu.utez.viajabara.basecatalog.person.model;

import mx.edu.utez.viajabara.basecatalog.state.model.State;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class PersonDto {
    @NotNull(groups = {Modify.class, ChangeStatus.class})
    private Long id;
    @NotBlank(groups = {Modify.class, Register.class})
    private String name;
    @NotBlank(groups = {Modify.class, Register.class})
    private String surname;
    private String secondSurname;

    @NotBlank(groups = {Modify.class, Register.class})
    private String cellphone;
    @NotBlank(groups = {Modify.class, Register.class})
    private String sex;
    private String birthDate;
    private String warrant;
    @NotNull(groups = {Modify.class, Register.class})
    private State state;

    private String contactEmail;
    private boolean status;

    public PersonDto(Person person) {
        this.id = person.getId();
        this.name = person.getName();
        this.surname = person.getSurname();
        this.secondSurname = person.getSurname();
        this.cellphone = person.getCellphone();
        this.sex = person.getSex();
        this.birthDate = person.getBirthDate().toString();
        this.state = person.getState();
        this.status = person.isStatus();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getSecondSurname() {
        return secondSurname;
    }

    public void setSecondSurname(String secondSurname) {
        this.secondSurname = secondSurname;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }



    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Date getBirthDate() {
        try {
            Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("America/Mexico_City"));
            Date date = new Date(birthDate);
            calendar.setTime(date);
            calendar.add(Calendar.DAY_OF_MONTH, 1);
            return calendar.getTime();
        } catch (Exception e) {
            return null;
        }
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getWarrant() {
        return warrant;
    }

    public void setWarrant(String warrant) {
        this.warrant = warrant;
    }


    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public interface Register {
    }

    public interface Modify {
    }

    public interface ChangeStatus {
    }

    @Override
    public String toString() {
        return "PersonDto{" +
                ", name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", secondSurname='" + secondSurname + '\'' +
                ", cellphone='" + cellphone + '\'' +
                ", sex='" + sex + '\'' +
                ", birthDate=" + birthDate +
                ", warrant='" + warrant + '\'' +
                ", status=" + status +
                '}';
    }
}
