import OperationsController from "../adapters/trip.controller";

const getTrip = async(payload) =>{
    const finalPayload={
        id: parseInt(payload)
    }
    const response = await OperationsController.getTrip(finalPayload)
    return response;
}


export default getTrip;