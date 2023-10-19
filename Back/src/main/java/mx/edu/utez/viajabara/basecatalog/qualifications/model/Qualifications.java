package mx.edu.utez.viajabara.basecatalog.qualifications.model;

import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;

import javax.persistence.*;

@Entity
@Table(name = "qualifications")
public class Qualifications {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private SeatingSales seatingSales;

    @Column(name = "comments", columnDefinition = "TEXT")
    private String comments;

    @Column(name = "score", columnDefinition = "FLOAT(5,2)")
    private double score;

    public Qualifications() {
    }

    public Qualifications(SeatingSales seatingSales, String comments, double score) {
        this.seatingSales = seatingSales;
        this.comments = comments;
        this.score = score;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public SeatingSales getSeatingSales() {
        return seatingSales;
    }

    public void setSeatingSales(SeatingSales seatingSales) {
        this.seatingSales = seatingSales;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }
}
