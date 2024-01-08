import Operations from "./opentrip.storage";

const OperationsController = {
    async openTrip(data){
      const response = await Operations.openTrip('/', data)
      return response;
    },

}

export default OperationsController;