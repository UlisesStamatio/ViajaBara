import OperationsController from "../adapters/trip.controller";

const newTrip = async(payload) =>{
    const response = await OperationsController.newTrip(payload)
    return response;
}


export default newTrip;