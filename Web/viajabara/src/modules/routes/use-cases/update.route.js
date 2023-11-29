import OperationsController from "../adapters/route.controller";

const updateRoute = async(payload) =>{
    const response = await OperationsController.updateRoute(payload)
    return response;
}


export default updateRoute;