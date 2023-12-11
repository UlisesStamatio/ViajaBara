import OperationsController from "../adapters/bus.controller";

const listTypeBusEnabled = async(payload) =>{
    const response = await OperationsController.listTypeBusEnabled(payload)
    return response;
}


export default listTypeBusEnabled;