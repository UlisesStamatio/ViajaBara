import OperationsController from "../adapters/method.controller";

const updateMethod = async(payload) =>{
    const {id, name, apikey} = payload
    payload = {
        id: id, 
        name: name,
        apikey: apikey
    }
    const response = await OperationsController.updateMethod(payload)
    return response;
}


export default updateMethod;