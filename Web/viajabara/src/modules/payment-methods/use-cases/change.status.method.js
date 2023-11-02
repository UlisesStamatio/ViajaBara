import OperationsController from "../adapters/method.controller";

const changeStatusMethod = async(id) =>{
    const payload = {
        id: parseInt(id)
    }
    const response = await OperationsController.changeStatusMethod(payload)
    return response;
}


export default changeStatusMethod;