package mx.edu.utez.viajabara.basecatalog.state.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.address.model.Address;
import mx.edu.utez.viajabara.basecatalog.person.model.Person;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "states")
public class State {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name", columnDefinition = "VARCHAR(50)")
    private String name;
    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;
    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @OneToMany(mappedBy = "state")
    @JsonIgnore
    private List<Person> people;

    @OneToMany(mappedBy = "state")
    @JsonIgnore
    private List<Address> addresses;

    public State() {
    }

    public State(String name, boolean status) {
        this.name = name;
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

    public void setName(String role) {
        this.name = role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", status=" + status +
                '}';
    }
}
