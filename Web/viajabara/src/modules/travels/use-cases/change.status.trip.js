import OperationsController from "../adapters/trip.controller";

const changeStatusTrip = async(payload) =>{
    const response = await OperationsController.changeStatusTrip(payload)
    return response;
}


export default changeStatusTrip;