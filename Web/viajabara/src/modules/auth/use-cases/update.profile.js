import OperationController from "../adapters/auth.controller"

const updateProfile = async(payload) =>{
    const response = await OperationController.updateProfile(payload)
    return response;
}

export default updateProfile;