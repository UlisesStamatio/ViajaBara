import axiosInstance from "../../../config/axios"
import { statusValidator } from "../../../kernel/validators/status.validator";
import router from "../../../router/index";
//const BASE_URL_AUTH = "/api/auth"
const BASE_URL_USER = "/api/user"
//const BASE_URL_DRIVER = "/api/driver"

const Operations = {
    async newUser(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL_USER}${url}`, JSON.stringify(data));
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

    async lisUsers(url){
      let response;
      try {
        response= await axiosInstance.get(`${BASE_URL_USER}${url}`);
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

    async listConsumers(url){
      let response;
      try {
        response= await axiosInstance.get(`${BASE_URL_USER}${url}`);
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
    async getUser(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_USER}${url}`, JSON.stringify(data));
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
    async updateUser(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_USER}${url}`, JSON.stringify(data));
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
    async changeStatusUser(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_USER}${url}`, JSON.stringify(data));
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