import OperationsController from "../adapters/route.controller";

const listRoutes = async() =>{
    const response = await OperationsController.listRoutes()
    return response;
}


export default listRoutes;