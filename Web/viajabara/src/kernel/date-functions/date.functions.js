import moment from 'moment'

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
        const fullDate = moment(dateHourString, 'YYYY-MM-DD HH:mm');
        const formatedDate = fullDate.format('YYYY-MM-DDTHH:mm:ss');
        return formatedDate;
    },
    getEndDate(starDate, minutes){
        const dateMoment = moment(starDate);
        const lastDate = dateMoment.add(minutes, 'minutes');
        return lastDate.format('YYYY-MM-DDTHH:mm:ss');
    }

}


export default dateFunctions;