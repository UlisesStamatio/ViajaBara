import OperationController from "../adapters/auth.controller"

const login = async(payload) =>{
    const response = await OperationController.login(payload)
    return response;
}

export default login;