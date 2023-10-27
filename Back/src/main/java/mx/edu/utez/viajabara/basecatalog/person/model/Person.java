package mx.edu.utez.viajabara.basecatalog.person.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.access.user.model.User;
import mx.edu.utez.viajabara.basecatalog.state.model.State;

import javax.persistence.*;
import javax.validation.constraints.Email;
import java.util.Date;

@Entity
@Table(name = "people")
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name", columnDefinition = "VARCHAR(50) NOT NULL")
    private String name;
    @Column(name = "surname", columnDefinition = "VARCHAR(50) NOT NULL")
    private String surname;
    @Column(name = "cellphone", columnDefinition = "VARCHAR(13)")
    private String cellphone;
    @Column(name = "sex", columnDefinition = "CHAR(1) NOT NULL")
    private String sex;
    @Column(name = "birth_date", columnDefinition = "TIMESTAMP NULL")
    @Temporal(TemporalType.TIMESTAMP)
    private Date birthDate;
    @ManyToOne
    private State state;
    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;
    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;
    @OneToOne(mappedBy = "person")
    @JsonIgnore
    private User user;


    public Person() {
    }

    public Person(String name, String surname, String cellphone, String sex, Date birthDate, boolean status) {
        this.name = name;
        this.surname = surname;
        this.cellphone = cellphone;
        this.sex = sex.toUpperCase();
        this.birthDate = birthDate;
        this.status = status;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void asignValues(PersonDto dto) {
        this.name = dto.getName();
        this.surname = dto.getSurname();
        this.cellphone = dto.getCellphone();
        this.sex = dto.getSex();
        this.birthDate = dto.getBirthDate();
    }

    public void asignValuesRegister(PersonDto dto) {
        asignValues(dto);
        this.status = true;
    }

    public void asignValuesModify(PersonDto dto) {
        this.id = dto.getId();
        asignValues(dto);
        this.status = dto.isStatus();
    }

    @Override
    public String toString() {
        return "{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", cellphone='" + cellphone + '\'' +
                ", sex='" + sex + '\'' +
                ", birthDate=" + birthDate +
                ", createdAt=" + createdAt +
                ", status=" + status +
                '}';
    }
}
