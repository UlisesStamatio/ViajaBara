import axiosInstance from "../../../config/axios"
import { statusValidator } from "../../../kernel/validators/status.validator";
import router from "../../../router/index";

const BASE_URL_OPEN_TRIPS= "/api/open-trips"


const Operations = {
    async openTrip(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL_OPEN_TRIPS}${url}`, JSON.stringify(data));
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error500'})
        }
      }
      return response;
    },
    async updateOpenTrip(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_OPEN_TRIPS}${url}`, JSON.stringify(data));
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error500'})
        }
      }
      return response;
    },

}

export default Operations;