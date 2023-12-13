
const REGEX_INJECTION_HTML = new RegExp('<[^>]*>')

const MAX_APIKEY = 255;
const MAX_NAME = 50;


const methodValidator = {

    validateName(name){
        if(!name) return "El campo es obligatorio.";
        if(name.length > MAX_NAME) return `El nombre debe ser menor a ${MAX_NAME} caracteres.`;
        else if(REGEX_INJECTION_HTML.test(name)) return "El nombre es inválido."
        return null;
    },
    validateApiKey(apikey){
        if(!apikey) return null;
        if(apikey.length > MAX_APIKEY) return `La ApiKey debe ser menor a ${MAX_APIKEY} caracteres.`;
        else if(REGEX_INJECTION_HTML.test(apikey)) return "El nombre es inválido."
        return null;
    },

}


export default methodValidator;