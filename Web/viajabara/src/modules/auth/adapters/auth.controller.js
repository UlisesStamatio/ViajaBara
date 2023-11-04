import Operations from "./auth.storage";
import storeSession from "../../../kernel/store/store.session";

const OperationsController = {
    async login(data){
      const response = await Operations.login('/login', data)
      if(!response.error){
        let {data:{token}} = response
        let {data} = response
        storeSession.setToken(token);
        storeSession.setDataSession(data)
      }
      return response;
    }
}

export default OperationsController;