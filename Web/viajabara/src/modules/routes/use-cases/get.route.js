import OperationsController from "../adapters/route.controller";

const getRoute = async(id) =>{
    const payload = {
        id: parseInt(id)
    }
    const response = OperationsController.getRoute(payload)
    return response;
}


export default getRoute;