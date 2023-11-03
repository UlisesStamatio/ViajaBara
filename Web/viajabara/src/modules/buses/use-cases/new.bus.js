import OperationsController from "../adapters/bus.controller";

const newBus = async(payload) =>{
    const response = await OperationsController.newBus(payload)
    return response;
}


export default newBus;