package mx.edu.utez.viajabara.basecatalog.duty.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.route.model.Route;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "duties")
public class Duty {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", columnDefinition = "VARCHAR(30)")
    private String name;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;


    @OneToMany(mappedBy = "duty")
    @JsonIgnore
    private List<Route> routes;

    public Duty() {
    }

    public Duty(String name, boolean status) {
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

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
