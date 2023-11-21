package mx.edu.utez.viajabara.basecatalog.qualifications.model;

import mx.edu.utez.viajabara.basecatalog.seatingSales.model.SeatingSales;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PositiveOrZero;

public class QualificationsDto {
    @NotNull(groups = {Modify.class})
    private Long id;
    @NotNull(groups = {Register.class})
    private SeatingSales seatingSales;
    @NotBlank(groups = {Register.class,Modify.class})
    private String comments;
    @PositiveOrZero(groups = {Register.class,Modify.class})
    private double score;

    public QualificationsDto() {
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

    public interface Register{}
    public interface Modify{}

}
