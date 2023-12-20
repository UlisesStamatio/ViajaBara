import OperationsController from "../adapters/trip.controller";

const openTrip = async(payload) =>{
    const response = await OperationsController.openTrip(payload)
    return response;
}


export default openTrip;