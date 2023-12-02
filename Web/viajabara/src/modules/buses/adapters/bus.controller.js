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
    async listBusesEnabled(){
        const response = await Operations.listBuses('/all-buses-enabled')
        return response;
    },
    async getBus(payload){
        const response = await Operations.getBus('/getOne', payload)
        return response;
    },
    async changeStatusBus(payload){
        const response = await Operations.changeStatusBus('/change-status', payload)
        return response;
    }
}

export default OperationsController;