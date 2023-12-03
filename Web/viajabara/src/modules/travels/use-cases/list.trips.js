import OperationsController from "../adapters/trip.controller";

const listTrips = async(payload) =>{
    const response = await OperationsController.listTrips(payload)
    return response;
}


export default listTrips;