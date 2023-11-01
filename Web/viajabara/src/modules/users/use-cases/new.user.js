import OperationsController from "../adapters/user.controller";

const newUser = async(payload) =>{
    const response = await OperationsController.newUser(payload)
    return response;
}


export default newUser;