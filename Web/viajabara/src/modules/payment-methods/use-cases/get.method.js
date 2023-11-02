import OperationsController from "../adapters/method.controller";

const getMethod = async(id) =>{
    let payload = {
        id: id
    }
    const response = await OperationsController.getMethod(payload)
    return response;
}


export default getMethod;