import OperationsController from "../adapters/user.controller";

const udpateUser = async(payload) =>{
    const response = await OperationsController.updateUser(payload)
    return response;
}


export default udpateUser;