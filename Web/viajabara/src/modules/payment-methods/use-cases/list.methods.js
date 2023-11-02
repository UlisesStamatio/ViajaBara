import OperationsController from "../adapters/method.controller";

const listMethods = async() =>{
    const response = await OperationsController.listMethods()
    return response;
}


export default listMethods;