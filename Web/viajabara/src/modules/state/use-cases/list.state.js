import OperationsController from "../adapters/state.controller";

const listStates = async() =>{
    const response = await OperationsController.listStates()
    return response;
}


export default listStates;