import OperationController from "../adapters/auth.controller"

const changeProfile = async(payload) =>{
    const response = await OperationController.changeProfile(payload)
    return response;
}

export default changeProfile;