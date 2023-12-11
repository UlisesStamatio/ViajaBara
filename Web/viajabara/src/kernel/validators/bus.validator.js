
const REGEX_INJECTION_HTML = new RegExp('<[^>]*>')
const MAX_PLAQUE = 13;
const MAX_MARK = 50;
// const REGEX_CELLPHONE = new RegExp('[0-9]{1,12}')
// const REGEX_EMAIL = new RegExp('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
//const REGEX_BIRTHDAY = new RegExp('/^(?:19|20)\d\d-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/')


const busValidator = {
    validateImage(file){
        if (!file) {
            return null // No se seleccionó ningún archivo
        }

        const allowedTypes = ["image/jpeg", "image/png", "image/gif"];
        if (allowedTypes.includes(file.type)) {
            return null;
        } else {
            return "El valor es inválido";
        }
    },
    validatePlaque(plaque){
        if(!plaque) return "El campo es obligatorio.";
        if(plaque.length > MAX_PLAQUE) return `La placa debe ser menor a ${MAX_PLAQUE} caracteres.`;
        else if(REGEX_INJECTION_HTML.test(plaque)) return "La placa es inválida."
        return null;
    },
    validateMark(mark){
        if(!mark) return "El campo es obligatorio.";
        if(mark.length > MAX_MARK) return `La marca debe ser menor a ${MAX_MARK} caracteres.`;
        else if(REGEX_INJECTION_HTML.test(mark)) return "La marca es inválida."
        return null;
    },
    validateModel(model){
        if(!model) return "El campo es obligatorio.";
        if(model.length > MAX_MARK) return `La modelo debe ser menor a ${MAX_MARK} caracteres.`;
        else if(REGEX_INJECTION_HTML.test(model)) return "El modelo es inválido."
        return null;
    },
    validateSerial(serial){
        if(!serial) return null;
        if(serial.length > MAX_PLAQUE) return `El serial debe ser menor a ${MAX_PLAQUE} caracteres.`;
        else if(REGEX_INJECTION_HTML.test(serial)) return "El serial es inválido."
        return null;
    },
    validateFuel(fuel){
        if(!fuel) return null;
        if(fuel.length > MAX_PLAQUE) return `El combustible debe ser menor a ${MAX_PLAQUE} caracteres.`;
        else if(REGEX_INJECTION_HTML.test(fuel)) return "El combustible es inválido."
        return null;
    },
    validateType(type){
        if(!type) return "Campo obligatorio.";
        return null;
    }
}


export default busValidator;