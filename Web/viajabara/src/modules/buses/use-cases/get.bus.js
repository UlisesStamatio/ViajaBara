import OperationsController from "../adapters/bus.controller";

const getBus = async(payload) =>{
    payload={
        id: payload
    }
    const response = await OperationsController.getBus(payload)
    return response;
}


export default getBus;