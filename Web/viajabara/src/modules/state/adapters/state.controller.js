import Operations from "./state.storage";

const OperationsController = {
    async listStates(){
        const response = await Operations.listStates('/all')
        return response;
    }
}

export default OperationsController;