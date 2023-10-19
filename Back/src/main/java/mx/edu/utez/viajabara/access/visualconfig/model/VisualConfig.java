package mx.edu.utez.viajabara.access.visualconfig.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "visual_config")
public class VisualConfig {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "background_aside", columnDefinition = "VARCHAR(50) NOT NULL")
    private String backgroundAside;
    @Column(name = "text_aside", columnDefinition = "VARCHAR(50) NOT NULL")
    private String textAside;
    @Column(name = "logo", columnDefinition = "LONGTEXT NOT NULL")
    private String logo;
    @Column(name = "kilometerPrice", columnDefinition = "FLOAT(5,2) NOT NULL")
    private double kilometerPrice;
    @Column(name = "status", columnDefinition = "BOOLEAN DEFAULT true")
    private boolean status = true;
    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    public VisualConfig() {
    }

    public VisualConfig(String backgroundAside, String textAside, String logoLogin, double kilometerPrice, boolean status) {
        this.backgroundAside = backgroundAside;
        this.textAside = textAside;
        this.logo = logoLogin;
        this.kilometerPrice = kilometerPrice;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getBackgroundAside() {
        return backgroundAside;
    }

    public void setBackgroundAside(String backgroundAside) {
        this.backgroundAside = backgroundAside;
    }

    public String getTextAside() {
        return textAside;
    }

    public void setTextAside(String textAside) {
        this.textAside = textAside;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public double getKilometerPrice() {
        return kilometerPrice;
    }

    public void setKilometerPrice(float kilometerPrice) {
        this.kilometerPrice = kilometerPrice;
    }

    public void assign(VisualConfigDto dto) {
        this.backgroundAside = dto.getBackgroundAside();
        this.textAside = dto.getTextAside();
        this.logo = dto.getLogo();
        this.kilometerPrice = dto.getKilometerPrice();
    }
}
