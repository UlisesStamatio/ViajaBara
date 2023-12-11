import OperationController from "../adapters/auth.controller"

const Autoregister = async(payload) =>{
    const response = await OperationController.autoregister(payload)
    return response;
}

export default Autoregister;