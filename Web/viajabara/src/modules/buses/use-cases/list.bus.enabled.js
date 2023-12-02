import OperationsController from "../adapters/bus.controller";

const listBusesEnabled = async() =>{
    const response = await OperationsController.listBusesEnabled()
    return response;
}


export default listBusesEnabled;