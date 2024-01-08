
const REGEX_INJECTION_HTML = new RegExp('<[^>]*>')



const openTripValidator = {

    validateNumberWeeks(number){
        number = number.toString()
        if(!number) return "El campo es obligatorio.";
        else if(REGEX_INJECTION_HTML.test(number)) return "El número de semanas es inválido."
        else if(number.length > 4) return "El número debe contar con al máximo 4 dígitos."
        return null;
    },
    validateSelect(value){
        if(!value || value === undefined || value === null) return 'Campo obligatorio.'
        return null
    },

}



export default openTripValidator;