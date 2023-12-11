package mx.edu.utez.viajabara.basecatalog.typeBus.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "types_bus")

public class TypeBus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "description", columnDefinition = "VARCHAR(1)")
    private String description;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @OneToMany(mappedBy = "typeBus", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Bus> buses;

    public TypeBus() {
    }

    public TypeBus( String description, boolean status) {
        this.description = description;
        this.status = status;
    }

    public TypeBus(Long id, String description, boolean status) {
        this.id = id;
        this.description = description;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
