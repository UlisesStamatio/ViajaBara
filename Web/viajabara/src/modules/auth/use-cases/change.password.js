import OperationController from "../adapters/auth.controller"

const changePassword = async(payload) =>{
    const response = await OperationController.changePassword(payload)
    return response;
}

export default changePassword;