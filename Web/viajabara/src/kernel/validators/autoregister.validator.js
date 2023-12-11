const REGEX_INJECTION_HTML = new RegExp('<[^>]*>')
const REGEX_CELLPHONE = new RegExp('[0-9]{1,12}')
const REGEX_EMAIL = new RegExp('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}');
const REGEX_PASSWORD = new RegExp('^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,20}$')

const Validations = {
    validateUsername(username){
      if(!username) return "Campo obligatorio"
      if(REGEX_INJECTION_HTML.test(username)) return "El nombre de usuario es inválido."
      return null
    }, 
    validateCode(code){
      if(!code) return "Campo obligatorio"
      if(code.length < 5) return "El código es inválido"
      return null
    }, 
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
    validateConfirmEmail(email, confirmEmail){
      if(!confirmEmail) return "Campo obligatorio."
      if(!REGEX_EMAIL.test(confirmEmail)) return "El correo es inválido."
      if(email !== confirmEmail) return "El correo electrónico no coincide."
      return null
    },
    validateCellphone(cellphone){
        if(cellphone < 0 ) return "El número de télefono es inválido."
        cellphone = cellphone.toString()
        if(!cellphone) return "El campo es obligatorio.";
        if(REGEX_INJECTION_HTML.test(cellphone)) return "El número de télefono es inválido."
        if(!REGEX_CELLPHONE.test(cellphone)) return "El número de télefono es inválido."
        if(cellphone.length !== 10) return "El número debe contar con al menos 10 dígitos."
        return null;
    },
    validatePassword(password){
        password = password.trim()
        if(!password){
            return "El campo es obligatorio."
        }else if(!REGEX_PASSWORD.test(password)){
            return "La contraseña no cumple con las características de contraseña segura."
        }else{
            return null
        }
    },
    validateConfirmPassword(password, confirmPassword){
        password = password.trim()
        confirmPassword = confirmPassword.trim();
        if(!password)return "El campo es obligatorio."
        if(!REGEX_PASSWORD.test(password))return "La contraseña no cumple con las características de contraseña segura."
        if(password !== confirmPassword) return "Las contraseñas no coinciden."
        return null
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




