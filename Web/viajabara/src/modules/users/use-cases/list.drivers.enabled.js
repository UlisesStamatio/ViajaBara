import OperationsController from "../adapters/user.controller";

const listDriversEnabled = async() =>{
    const response = await OperationsController.listDriversEnabled()
    return response;
}


export default listDriversEnabled;