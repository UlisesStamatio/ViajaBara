import OperationsController from "../adapters/opentrip.controller";

const updateOpenTrip = async(payload) =>{
    const response = await OperationsController.updateOpenTrip(payload)
    return response;
}


export default updateOpenTrip;