import OperationsController from "../adapters/bus.controller";

const updateBus = async(payload) =>{
    const response = await OperationsController.updateBus(payload)
    return response;
}


export default updateBus;