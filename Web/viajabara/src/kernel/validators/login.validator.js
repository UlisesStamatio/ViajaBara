
const validations = {
    validateName(username){
        if(!username){
            return "El campo es obligatorio."
        }else{
            return null
        }
    },
    validatePassword(password){

    },
    validateCapcha(valueGenerated, valueEntered){

    }
}


export default validations;




