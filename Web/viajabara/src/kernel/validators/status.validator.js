import { Response } from "../models/response"
import router from "../../router"

export const statusValidator = (response) =>{
    if(response.status === 200 || response.status === 201){
        return {...Response, error: false, message: "Operación realizada con éxito", data: response.data}
    }else if(response.status === 400){
        return {...Response, error: true, message: "Operación realizada con éxito", data: response.data}
    }else if(response.status === 404){
        router.push({name: 'Error Error404'})
    }else if(response.status === 500){
        router.push({name: 'Error Error500'})
    }else if(response.status === 403 || response.status ===  401){
        router.push({name: 'Error Error500'})
    }else {
        router.push({name: 'Error Error404'})
    }

}