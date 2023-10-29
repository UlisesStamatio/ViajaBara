
const REGEX_EMAIL = new RegExp('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');

const Validations = {
    validateEmail(email){
        email = email.trim()

        if(!email){
            return "El campo es obligatorio."
        }else if(!REGEX_EMAIL.test(email)){
            return "El correo es inválido."
        }else{
            return null
        }
    },
    validatePassword(password){
        password = password.trim()
        if(!password){
            return "El campo es obligatorio."
        }else{
            return null
        }
    },
    validateCapcha(valueGenerated, valueEntered){
        valueEntered = valueEntered.trim()
        if(!valueEntered){
            return "El campo es obligatorio."
        }else if(valueEntered !== valueGenerated){
            return "Los valores no coinciden"
        }else{
            return null
        }
    },
}


export default Validations;




