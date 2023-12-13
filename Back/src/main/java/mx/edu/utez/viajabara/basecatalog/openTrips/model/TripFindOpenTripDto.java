package mx.edu.utez.viajabara.basecatalog.openTrips.model;


public class TripFindOpenTripDto {
    private Long id;
    private String startDate;

    public TripFindOpenTripDto() {
    }

    public TripFindOpenTripDto(Long id, String startDate) {
        this.id = id;
        this.startDate = startDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }
}
