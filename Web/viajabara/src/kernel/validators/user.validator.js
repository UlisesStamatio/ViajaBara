
const REGEX_INJECTION_HTML = new RegExp('<[^>]*>')
const REGEX_CELLPHONE = new RegExp('[0-9]{1,12}')
const REGEX_EMAIL = new RegExp('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
//const REGEX_BIRTHDAY = new RegExp('/^(?:19|20)\d\d-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/')


const userValidator = {
    validateImage(file){
        if (!file) {
            return "El valor es inválido y se ha reemplazado." // No se seleccionó ningún archivo
        }

        const allowedTypes = ["image/jpeg", "image/png", "image/gif"];
        if (allowedTypes.includes(file.type)) {
            return null;
        } else {
            return "El valor es inválido y se ha reemplazado.";
        }
    },
    validateName(name){
        if(!name) return "El campo es obligatorio.";
        else if(REGEX_INJECTION_HTML.test(name)) return "El nombre es inválido."
        return null;
    },
    validateLastname(lastname){
        if(!lastname) return "El campo es obligatorio.";
        else if(REGEX_INJECTION_HTML.test(lastname)) return "El apellido paterno es inválido."
        return null;
    },
    validateSurname(surname){
        if(REGEX_INJECTION_HTML.test(surname)) return "El apellido materno es inválido."
        return null;
    },
    validateSex(option){
        option = parseInt(option)
        if(!option || option === '') return "El campo es obligatorio.";
        else if(option !== 2 && option !== 1) return "La opción es incorrecta."
        else if(REGEX_INJECTION_HTML.test(option)) return "El sexo es inválido."
        return null;
    },
    validateBirthday(birthday){
        if(!birthday) return "El campo es obligatorio.";
        else if(REGEX_INJECTION_HTML.test(birthday)) return "La fecha de nacimiento es inválida."
        return null;
    },
    validateState(option, states){
        option = parseInt(option)
        if(!option || option === '') return "El campo es obligatorio.";
        else if(option < 1 || option > (states.length + 1) ) return "La opción es incorrecta."
        else if(REGEX_INJECTION_HTML.test(option)) return "El estado de residencia es inválido."
        return null;
    },
    validateCellphone(cellphone){
        if(!cellphone) return "El campo es obligatorio.";
        else if(REGEX_INJECTION_HTML.test(cellphone)) return "El número de télefono es inválido."
        else if(!REGEX_CELLPHONE.test(cellphone)) return "El número de télefono es inválido."
        else if(cellphone.length !== 10) return "El número debe contar con al menos 10 dígitos."
        return null;
    },
    validateEmail(email){
        if(!email) return "El campo es obligatorio."
        else if(!REGEX_EMAIL.test(email)) return "El correo es inválido."
        return null

    },
    validateConfirmEmail(email, confirmEmail){
        if(!confirmEmail) return "El campo es obligatorio."
        else if(!REGEX_EMAIL.test(confirmEmail)) return "El correo es inválido."
        else if(confirmEmail !== email) return "Los correos no coinciden."
        return null

    },
    validateUsername(username){
        if(!username) return "El campo es obligatorio.";
        else if(REGEX_INJECTION_HTML.test(username)) return "El nombre es inválido."
        return null;
    },


}


export default userValidator;