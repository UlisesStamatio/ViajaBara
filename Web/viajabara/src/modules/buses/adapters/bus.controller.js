import Operations from "./bus.storage";

const OperationsController = {
    async newBus(data){
      const response = await Operations.newBus('/', data)
      return response;
    },
    async updateBus(data){
      const response = await Operations.updateBus('/', data)
      return response;
    },
    async listBuses(){
        const response = await Operations.listBuses('/all')
        return response;
    },
    // async listConsumers(){
    //     const response = await Operations.listConsumers('/all-consumers')
    //     return response;
    // },
    async getBus(payload){
        const response = await Operations.getBus('/getOne', payload)
        return response;
    },
    // async changeStatusUser(payload){
    //     const response = await Operations.changeStatusUser('/change-status', payload)
    //     return response;
    // }
}

export default OperationsController;