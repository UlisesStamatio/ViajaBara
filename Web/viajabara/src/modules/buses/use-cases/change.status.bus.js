import OperationsController from "../adapters/bus.controller";

const changeStatusBus = async(payload) =>{
    payload={
        id: payload
    }
    const response = await OperationsController.changeStatusBus(payload)
    return response;
}


export default changeStatusBus;