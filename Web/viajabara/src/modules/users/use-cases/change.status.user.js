import OperationsController from "../adapters/user.controller";

const changeStatusUser = async(id) =>{
    const payload = {
        id: parseInt(id)
    }
    const response = await OperationsController.changeStatusUser(payload)
    return response;
}


export default changeStatusUser;