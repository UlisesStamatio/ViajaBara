import OperationsController from "../adapters/user.controller";

const listUsers = async() =>{
    const response = await OperationsController.listUsers()
    return response;
}


export default listUsers;