package mx.edu.utez.viajabara.access.user.model;

import mx.edu.utez.viajabara.access.role.model.Role;
import mx.edu.utez.viajabara.basecatalog.person.model.Person;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

public class UserDto {
    @NotNull(groups = {Modify.class, Restore.class, ChangeStatus.class})
    private Long id;
    @NotBlank(groups = {Modify.class, Register.class})
    private String username;
    @NotBlank(groups = {Modify.class, Register.class})
    private String profile;
    @NotBlank(groups = {Modify.class, Register.class, Recover.class, ChangePassword.class, VerifyCode.class, UpdatePassword.class})
    private String email;
    @NotBlank(groups = {ChangePassword.class, UpdatePassword.class})
    private String password;
    @NotNull(groups = {Modify.class, Register.class})
    private Person person;
    @NotNull(groups = {Modify.class, Register.class, ChangeRole.class})
    private List<Role> roles;
    @NotBlank(groups = {UpdatePassword.class})
    private String passwordNew;
    @NotBlank(groups = {VerifyCode.class, ChangePassword.class})
    private String recuperation;
    private boolean changePassword;
    private Date dateExpiration;
    private boolean status;

    public UserDto() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRecuperation() {
        return recuperation;
    }

    public void setRecuperation(String recuperation) {
        this.recuperation = recuperation;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public Person getPerson() {
        return person;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public Date getDateExpiration() {
        return dateExpiration;
    }

    public void setDateExpiration(Date dateExpiration) {
        this.dateExpiration = dateExpiration;
    }

    public boolean isChangePassword() {
        return changePassword;
    }

    public void setChangePassword(boolean changePassword) {
        this.changePassword = changePassword;
    }

    public String getPasswordNew() {
        return passwordNew;
    }

    public void setPasswordNew(String passwordNew) {
        this.passwordNew = passwordNew;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public interface Register {
    }

    public interface Modify {
    }

    public interface Recover {
    }

    public interface ChangePassword {
    }

    public interface VerifyCode {
    }

    public interface UpdatePassword {
    }

    public interface ChangeStatus {
    }

    public interface Restore {
    }

    public interface ChangeRole {
    }

}
