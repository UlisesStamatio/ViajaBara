package mx.edu.utez.viajabara.utils.validator;

import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripSchedule;

import java.util.List;

public class TripValidator {

    public TripValidator() {
    }

    public  boolean validateTripSchedules(List<TripSchedule> list1, List<TripSchedule> list2) {
        for (TripSchedule event1 : list1) {
            for (TripSchedule event2 : list2) {
                if (event1.intersects(event2)) {
                    return false;
                }
            }
        }
        return true;
    }
}
