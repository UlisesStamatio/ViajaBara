import OperationsController from "../adapters/trip.controller";

const listTripsOpened = async() =>{
    const response = await OperationsController.listTripsOpened()
    return response;
}


export default listTripsOpened;