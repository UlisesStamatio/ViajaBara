import OperationsController from "../adapters/route.controller";

const changeStatusRoute = async(payload) =>{
    const response = await OperationsController.changeStatusRoute(payload)
    return response;
}


export default changeStatusRoute;