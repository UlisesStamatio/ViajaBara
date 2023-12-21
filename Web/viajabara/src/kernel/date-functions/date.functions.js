import moment from 'moment-timezone'

const dateFunctions = {
    getDateCurrentWeekByDay(day){
          const currentDate = moment();
          const dayOfCurrentWeek = currentDate.isoWeekday();
          const diferenceBetweenDays = day - dayOfCurrentWeek;
          const wishedDate = currentDate.add(diferenceBetweenDays, 'days');
          return wishedDate.format('YYYY-MM-DD');
    },
    generateFullDate(date, hour){
        const dateHourString = `${date} ${hour}`;
        const fullDate = moment.tz(dateHourString, 'America/Mexico_City');
        const formatedDate = fullDate.format('YYYY-MM-DDTHH:mm:ss.sssZ');
        return formatedDate;
    },
    getEndDate(starDate, minutes){
        const dateMoment = moment.tz(starDate, 'America/Mexico_City');
        const lastDate = dateMoment.add(minutes, 'minutes');
        return lastDate.format('YYYY-MM-DDTHH:mm:ss.sssZ');
    }

}


export default dateFunctions;