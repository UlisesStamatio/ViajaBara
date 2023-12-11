import axiosInstance from "../../../config/axios"
import { statusValidator } from "../../../kernel/validators/status.validator";
import router from "../../../router";
const BASE_URL = "/api/auth"
const BASE_LOGGER_URL = "/api/logged"

const Operations = {
    async login(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL}${url}`, JSON.stringify(data));
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
    async updateProfile(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_LOGGER_URL}${url}`, JSON.stringify(data));
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
    async autoregister(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL}${url}`, JSON.stringify(data));
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
    async recover(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL}${url}`, JSON.stringify(data));
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
    async changePassword(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL}${url}`, JSON.stringify(data));
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