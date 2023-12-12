import axiosInstance from "../../../config/axios"
import { statusValidator } from "../../../kernel/validators/status.validator";
import router from "../../../router/index";
const BASE_URL_METHOD = "/api/payment-methods"


const Operations = {
    async newMethod(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL_METHOD}${url}`, JSON.stringify(data));
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

    async listMethods(url){
      let response;
      try {
        response= await axiosInstance.get(`${BASE_URL_METHOD}${url}`);
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

    // async listConsumers(url){
    //   let response;
    //   try {
    //     response= await axiosInstance.get(`${BASE_URL_USER}${url}`);
    //     response = statusValidator(response);
    //   } catch (error) {
    //     if(error.response){
    //       response = statusValidator(error.response);
    //     }else{
    //       router.push({name: 'Error Error500'})
    //     }
    //   }
    //   return response;
    // },
    async getMethod(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_METHOD}${url}`, JSON.stringify(data));
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
    async updateMethod(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_METHOD}${url}`, JSON.stringify(data));
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
    async changeStatusMethod(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_METHOD}${url}`, JSON.stringify(data));
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