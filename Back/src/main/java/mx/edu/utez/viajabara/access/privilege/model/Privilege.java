package mx.edu.utez.viajabara.access.privilege.model;

import javax.persistence.*;

@Entity
@Table(name = "privilegies")
public class Privilege {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Enumerated(EnumType.STRING)
    @Column(name = "name", columnDefinition = "VARCHAR(50)")
    private PrivilegeName name;
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    public Privilege() {
    }

    public Privilege(PrivilegeName name, String description) {
        this.name = name;
        this.description = description;
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

    public void setDescription(String role) {
        this.description = role;
    }

    public PrivilegeName getName() {
        return name;
    }

    public void setName(PrivilegeName code) {
        this.name = code;
    }
    
    @Override
    public String toString() {
        return "{" +
                "\"id\": \"" + id +
                "\", \"name\": \"" + name +
                "\", \"description\": \"" + description +
                "\"}";
    };
}
