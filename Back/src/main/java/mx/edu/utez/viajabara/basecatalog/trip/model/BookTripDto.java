package mx.edu.utez.viajabara.basecatalog.trip.model;

import javax.validation.constraints.NotNull;

public class BookTripDto {
    @NotNull(groups = {Get.class})
    private String date;
    @NotNull(groups = {Get.class})
    private int dutyId;
    @NotNull(groups = {Get.class})
    private int stateOriginId;
    @NotNull(groups = {Get.class})
    private int stateDestinyId;
    @NotNull(groups = {Get.class})
    private int originId;
    @NotNull(groups = {Get.class})
    private int destinyId;
    @NotNull(groups = {Get.class})
    private int seats;
    @NotNull(groups = {Get.class})
    private int tripId;
    @NotNull(groups = {Get.class})
    private String seatsSelected;
    @NotNull(groups = {Get.class})
    private String cvc;
    @NotNull(groups = {Get.class})
    private String cardNumber;
    @NotNull(groups = {Get.class})
    private double price;

    public BookTripDto() {
    }

    public BookTripDto(String date, int dutyId, int stateOriginId, int stateDestinyId, int originId, int destinyId, int seats, int tripId, String seatsSelected, String cvc, String cardNumber, double price) {
        this.date = date;
        this.dutyId = dutyId;
        this.stateOriginId = stateOriginId;
        this.stateDestinyId = stateDestinyId;
        this.originId = originId;
        this.destinyId = destinyId;
        this.seats = seats;
        this.tripId = tripId;
        this.seatsSelected = seatsSelected;
        this.cvc = cvc;
        this.cardNumber = cardNumber;
        this.price = price;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getDutyId() {
        return dutyId;
    }

    public void setDutyId(int dutyId) {
        this.dutyId = dutyId;
    }

    public int getStateOriginId() {
        return stateOriginId;
    }

    public void setStateOriginId(int stateOriginId) {
        this.stateOriginId = stateOriginId;
    }

    public int getStateDestinyId() {
        return stateDestinyId;
    }

    public void setStateDestinyId(int stateDestinyId) {
        this.stateDestinyId = stateDestinyId;
    }

    public int getOriginId() {
        return originId;
    }

    public void setOriginId(int originId) {
        this.originId = originId;
    }

    public int getDestinyId() {
        return destinyId;
    }

    public void setDestinyId(int destinyId) {
        this.destinyId = destinyId;
    }

    public int getSeats() {
        return seats;
    }

    public void setSeats(int seats) {
        this.seats = seats;
    }

    public int getTripId() {
        return tripId;
    }

    public void setTripId(int tripId) {
        this.tripId = tripId;
    }

    public String getSeatsSelected() {
        return seatsSelected;
    }

    public void setSeatsSelected(String seatsSelected) {
        this.seatsSelected = seatsSelected;
    }

    public String getCvc() {
        return cvc;
    }

    public void setCvc(String cvc) {
        this.cvc = cvc;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "BookTripDto{" +
                "date='" + date + '\'' +
                ", dutyId=" + dutyId +
                ", stateOriginId=" + stateOriginId +
                ", stateDestinyId=" + stateDestinyId +
                ", originId=" + originId +
                ", destinyId=" + destinyId +
                ", seats=" + seats +
                ", tripId=" + tripId +
                ", seatsSelected='" + seatsSelected + '\'' +
                ", cvc='" + cvc + '\'' +
                ", cardNumber='" + cardNumber + '\'' +
                ", price=" + price +
                '}';
    }

    public interface Get{}

}
