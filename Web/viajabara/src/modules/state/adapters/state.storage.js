import axiosInstance from "../../../config/axios"
import { statusValidator } from "../../../kernel/validators/status.validator";
import router from "../../../router/index";
const BASE_URL_STATE = "/api/state"

const Operations = {
    async listStates(url){
      let response;
      try {
        response= await axiosInstance.get(`${BASE_URL_STATE}${url}`);
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error500'})
        }
      }
      return response;
    }
}

export default Operations;