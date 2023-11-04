import axiosInstance from "../../../config/axios"
import { statusValidator } from "../../../kernel/validators/status.validator";
import router from "../../../router";
const BASE_URL = "/api/auth"

const Operations = {
    async login(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL}${url}`, JSON.stringify(data));
        console.log(response);
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error403'})
        }
      }
      return response;
    }
}

export default Operations;