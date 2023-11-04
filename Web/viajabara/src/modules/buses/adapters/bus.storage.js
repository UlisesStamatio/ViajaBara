import axiosInstance from "../../../config/axios"
import { statusValidator } from "../../../kernel/validators/status.validator";
import router from "../../../router/index";
const BASE_URL_BUS = "/api/buses"

const Operations = {
    async newBus(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL_BUS}${url}`, JSON.stringify(data));
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error403'})
        }
      }
      return response;
    },

    async listBuses(url){
      let response;
      try {
        response= await axiosInstance.get(`${BASE_URL_BUS}${url}`);
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error403'})
        }
      }
      return response;
    },
    async getBus(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_BUS}${url}`, JSON.stringify(data));
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error403'})
        }
      }
      return response;
    },
    async updateBus(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_BUS}${url}`, JSON.stringify(data));
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error403'})
        }
      }
      return response;
    },
    async changeStatusBus(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_BUS}${url}`, JSON.stringify(data));
        response = statusValidator(response);
      } catch (error) {
        if(error.response){
          response = statusValidator(error.response);
        }else{
          router.push({name: 'Error Error403'})
        }
      }
      return response;
    },
}

export default Operations;