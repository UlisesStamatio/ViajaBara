import Operations from "./route.storage";

const OperationsController = {
    async newRoute(data){
      const response = await Operations.newRoute('/', data)
      return response;
    },
    async updateRoute(data){
      const response = await Operations.updateRoute('/', data)
      return response;
    },
    async listRoutes(){
        const response = await Operations.listRoutes('/all')
        return response;
    },
    // async listConsumers(){
    //     const response = await Operations.listConsumers('/all-consumers')
    //     return response;
    // },
    async getRoute(payload){
        const response = await Operations.getRoute('/getOne', payload)
        return response;
    },
    // async getProfile(payload){
    //     const response = await Operations.getUser('/one', payload)
    //     return response;
    // },
    // async changeStatusUser(payload){
    //     const response = await Operations.changeStatusUser('/change-status', payload)
    //     return response;
    // }
}

export default OperationsController;