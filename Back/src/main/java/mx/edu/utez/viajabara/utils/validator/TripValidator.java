package mx.edu.utez.viajabara.utils.validator;

import mx.edu.utez.viajabara.basecatalog.trip.model.Trip;
import mx.edu.utez.viajabara.basecatalog.tripSchedule.model.TripSchedule;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

    public List<Date> generateDatesByRange(Date startDate, Date defaultTime, int[] days){
        Calendar calendarForEndDate = Calendar.getInstance();
        calendarForEndDate.setTime(startDate);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        calendarForEndDate.add(Calendar.DAY_OF_MONTH, 7);
        Date endDate = calendarForEndDate.getTime();
        List<Date> dates = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

        while (calendar.getTime().before(endDate)) {

            int dayWeek = calendar.get(Calendar.DAY_OF_WEEK);
            if (contain(days, dayWeek)) {
                calendar.set(Calendar.HOUR_OF_DAY, defaultTime.getHours());
                calendar.set(Calendar.MINUTE, defaultTime.getMinutes());
                calendar.set(Calendar.SECOND, defaultTime.getSeconds());
                dates.add(calendar.getTime());
            }
            calendar.add(Calendar.DAY_OF_MONTH, 1);
        }
        return dates;
    }

    public List<TripSchedule> generateTripSchedules(List<Date> dates, double time, Trip trip){
        List<TripSchedule> tripSchedules = new ArrayList<>();
        for (Date date: dates) {
            TripSchedule tripSchedule = new TripSchedule();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);

            calendar.add(Calendar.MINUTE, (int) time);

            Date endDate = calendar.getTime();
            tripSchedule.setTrip(trip);
            tripSchedule.setStartDate(date);
            tripSchedule.setEndDate(endDate);
            tripSchedule.setStatus(true);
            tripSchedules.add(tripSchedule);
        }
        return tripSchedules;
    }


    private static boolean contain(int[] array, int value) {
        for (int item : array) {
            if (item == value) {
                return true;
            }
        }
        return false;
    }


}
