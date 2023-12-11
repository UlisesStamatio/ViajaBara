import OperationController from "../adapters/auth.controller"

const Recover = async(payload) =>{
    const response = await OperationController.recover(payload)
    return response;
}

export default Recover;