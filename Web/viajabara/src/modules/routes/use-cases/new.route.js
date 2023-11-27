import OperationsController from "../adapters/route.controller";

const newRoute = async(payload) =>{
    const response = await OperationsController.newRoute(payload)
    return response;
}


export default newRoute;