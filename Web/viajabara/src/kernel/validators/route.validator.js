
const REGEX_INJECTION_HTML = new RegExp('<[^>]*>')

const MAX_NAME = 15;

const routeValidator = {
   isSameStopOver(stopovers, lat, lng){
    if(stopovers.filter(stopover => stopover.lat === lat && stopover.lng === lng).length > 0) return "La parada ya se ha añadido." ;
    return null;
   },
   validateName(name){
    if(!name) return "Campo obligatorio."
    if(name.length > MAX_NAME) return "El nombre debe contener máximo 15 caracteres."
    if(REGEX_INJECTION_HTML.test(name)) return "El nombre es inválido."
    return null;
   },
    validateStopovers(stopovers){
    if(!stopovers) return "Ingresa al menos dos paradas."
    if(stopovers.length < 2) return "Ingresa al menos dos paradas."
    return null;
   }

}


export default routeValidator;