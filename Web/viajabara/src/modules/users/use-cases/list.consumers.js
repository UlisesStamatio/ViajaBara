import OperationsController from "../adapters/user.controller";

const listConsumers = async() =>{
    const response = await OperationsController.listConsumers()
    return response;
}


export default listConsumers;