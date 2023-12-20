import axiosInstance from "../../../config/axios"
import { statusValidator } from "../../../kernel/validators/status.validator";
import router from "../../../router/index";
const BASE_URL_TRIP= "/api/trips"
const BASE_URL_OPEN_TRIPS= "/api/open-trips"


const Operations = {
    async newTrip(url, data){
      let response;
      try {
        response= await axiosInstance.post(`${BASE_URL_TRIP}${url}`, JSON.stringify(data));
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

    async listTrips(url){
      let response;
      try {
        response= await axiosInstance.get(`${BASE_URL_TRIP}${url}`);
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
    async getTrip(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_TRIP}${url}`, JSON.stringify(data));
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
    async updateTrip(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_TRIP}${url}`, JSON.stringify(data));
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
    async changeStatusTrip(url, data){
      let response;
      try {
        response= await axiosInstance.put(`${BASE_URL_TRIP}${url}`, JSON.stringify(data));
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
}

export default Operations;