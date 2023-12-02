import Operations from "./trip.storage";

const OperationsController = {
    async newTrip(data){
      const response = await Operations.newTrip('/', data)
      return response;
    },
    // async updateRoute(data){
    //   const response = await Operations.updateRoute('/', data)
    //   return response;
    // },
    // async listRoutes(){
    //     const response = await Operations.listRoutes('/all')
    //     return response;
    // },
    // async listRoutesEnabled(){
    //     const response = await Operations.listRoutes('/enabled')
    //     return response;
    // },
    // async listConsumers(){
    //     const response = await Operations.listConsumers('/all-consumers')
    //     return response;
    // },
    // async getRoute(payload){
    //     const response = await Operations.getRoute('/getOne', payload)
    //     return response;
    // },
    // async getProfile(payload){
    //     const response = await Operations.getUser('/one', payload)
    //     return response;
    // },
    // async changeStatusRoute(payload){
    //     const response = await Operations.changeStatusRoute('/change-status', payload)
    //     return response;
    // }
}

export default OperationsController;