import Operations from "./auth.storage";
import storeSession from "../../../kernel/store/store.session";

const OperationsController = {
    async login(data){
      const response = await Operations.login('/login', data)
      if(!response.error){
        let {data:{token}} = response
        let {data} = response
        let {roles} = data;
        if(roles.some((rol) => rol.keyRole === 'ADMIN')){
          storeSession.setToken(token);
          storeSession.setDataSession(data)
        }

      }
      return response;
    },
    async updateProfile(data){
      const response = await Operations.updateProfile('/update-user', data)
      return response;
    },
    async changeProfile(data){
      const response = await Operations.updateProfile('/change-profile', data)
      return response;
    },
    async autoregister(data){
      const response = await Operations.autoregister('/register', data)
      return response;
    },
    async recover(data){
      const response = await Operations.recover('/recover', data)
      return response;
    },
    async changePassword(data){
      const response = await Operations.changePassword('/change-password', data)
      return response;
    }
}

export default OperationsController;