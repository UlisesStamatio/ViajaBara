import OperationsController from "../adapters/trip.controller";

const updateTrip = async(payload) =>{
    const response = await OperationsController.updateTrip(payload)
    return response;
}


export default updateTrip;