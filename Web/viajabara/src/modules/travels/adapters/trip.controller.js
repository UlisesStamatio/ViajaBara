import Operations from "./trip.storage";

const OperationsController = {
    async newTrip(data){
      const response = await Operations.newTrip('/', data)
      return response;
    },
    async updateTrip(data){
      const response = await Operations.updateTrip('/', data)
      return response;
    },
    async listTrips(){
        const response = await Operations.listTrips('/all')
        return response;
    },
    async listTripsUnopened(){
        const response = await Operations.listTrips('/unopened')
        return response;
    },
    // async listConsumers(){
    //     const response = await Operations.listConsumers('/all-consumers')
    //     return response;
    // },
    // async getRoute(payload){
    //     const response = await Operations.getRoute('/getOne', payload)
    //     return response;
    // },
    async getTrip(payload){
        const response = await Operations.getTrip('/getOne', payload)
        return response;
    },
    async changeStatusTrip(payload){
        const response = await Operations.changeStatusTrip('/change-status', payload)
        return response;
    },
    async openTrip(payload){
        const response = await Operations.openTrip('/', payload)
        return response;
    }
}

export default OperationsController;