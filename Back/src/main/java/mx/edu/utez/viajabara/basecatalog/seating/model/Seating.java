package mx.edu.utez.viajabara.basecatalog.seating.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import mx.edu.utez.viajabara.basecatalog.bus.model.Bus;
import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "seatings")
public class Seating {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "num_columns", columnDefinition = "INT")
    private int columns;

    @Column(name = "num_rows", columnDefinition = "INT")
    private int rows;

    @Column(name = "create_at", insertable = false, columnDefinition = "TIMESTAMP DEFAULT NOW()")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Column(name = "status", columnDefinition = "BOOL DEFAULT TRUE")
    private boolean status;

    @ManyToOne
    private Bus bus;

    @OneToMany(mappedBy = "seating")
    @JsonIgnore
    private List<SeatingSales> seatingSales;

    public Seating() {
    }

    public Seating(int columns, int rows, boolean status, Bus bus) {
        this.columns = columns;
        this.rows = rows;
        this.status = status;
        this.bus = bus;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getColumn() {
        return columns;
    }

    public void setColumn(int column) {
        this.columns = column;
    }

    public int getRow() {
        return rows;
    }

    public void setRow(int row) {
        this.rows = row;
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

    public Bus getBus() {
        return bus;
    }

    public void setBus(Bus bus) {
        this.bus = bus;
    }
}
