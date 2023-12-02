import OperationsController from "../adapters/route.controller";

const listRoutesEnabled = async() =>{
    const response = await OperationsController.listRoutesEnabled()
    return response;
}


export default listRoutesEnabled;