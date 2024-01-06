import OperationsController from "../adapters/trip.controller";

const listTripsUnopened = async() =>{
    const response = await OperationsController.listTripsUnopened()
    return response;
}


export default listTripsUnopened;