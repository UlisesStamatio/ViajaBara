import OperationsController from "../adapters/method.controller";

const newMethod = async(payload) =>{
    const response = await OperationsController.newMethod(payload)
    return response;
}


export default newMethod;