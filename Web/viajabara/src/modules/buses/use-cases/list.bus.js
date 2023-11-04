import OperationsController from "../adapters/bus.controller";

const listBuses = async() =>{
    const response = await OperationsController.listBuses()
    return response;
}


export default listBuses;