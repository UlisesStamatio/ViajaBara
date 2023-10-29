import Operations from "./auth.storage";
import storeSession from "../../../kernel/store/store.session";

const OperationsController = {
    async login(data){
      const response = await Operations.login('/login', data)
      if(!response.error){
        let {data:{token}} = response
        storeSession.setToken(token);
      }
      return response;
    }
}

export default OperationsController;