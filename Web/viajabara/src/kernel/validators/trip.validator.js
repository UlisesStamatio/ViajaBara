


const tripValidator = {
    validateSelect(value){
        if(!value || value === undefined || value === null) return 'Campo obligatorio.'
        return null
    },
    validateMultiSelect(value){
        if(!value || value === undefined || value === null) return 'Campo obligatorio.'
        if(value.length === 0) return 'Campo obligatorio.'
        return null
    },
    validateDate(date){
        if(!date || date === undefined || date === null) return 'Campo obligatorio.'
        return null
    }
}


export default tripValidator;