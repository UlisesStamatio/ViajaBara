import Operations from "./method.storage";

const OperationsController = {
    async newMethod(data){
      const response = await Operations.newMethod('/', data)
      return response;
    },
    async updateMethod(data){
      const response = await Operations.updateMethod('/', data)
      return response;
    },
    async listMethods(){
        const response = await Operations.listMethods('/all')
        return response;
    },
    // async listConsumers(){
    //     const response = await Operations.listConsumers('/all-consumers')
    //     return response;
    // },
    async getMethod(payload){
        const response = await Operations.getMethod('/one', payload)
        return response;
    },
    async changeStatusMethod(payload){
        const response = await Operations.changeStatusMethod('/change-status', payload)
        return response;
    }
}

export default OperationsController;