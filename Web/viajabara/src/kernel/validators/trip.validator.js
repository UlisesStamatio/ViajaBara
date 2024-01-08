const MAX_NAME = 50


const tripValidator = {
    validateName(name){
        if(!name || name === undefined || name === '') return "Campo obligatorio."
        if(name.length > MAX_NAME) return `Ingresa máximo ${MAX_NAME} caracteres.`
        return null
    },
    validateSelect(value){
        if(!value || value === undefined || value === null) return 'Campo obligatorio.'
        return null
    },
    validateMultiSelect(value){
        if( value === undefined || value === null) return 'Campo obligatorio.'
        if(value.length === 0) return 'Campo obligatorio.'
        return null
    },
    validateDate(date){
        if(!date || date === undefined || date === null) return 'Campo obligatorio.'
        return null
    },
    validateWays(ways){
        if(ways.length < 2) return "Ingresa al menos dos rutas para el viaje."
        return null;
    }
}


export default tripValidator;