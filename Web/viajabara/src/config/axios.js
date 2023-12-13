
import axios from "axios";
const BASE_URL = "http://44.212.110.134:8083";


const axiosInstance = axios.create({
    baseURL: BASE_URL,
    headers:{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
    }
})

axiosInstance.interceptors.request.use((config) =>{
    const token = JSON.parse(localStorage.getItem('session'));
    if(token){
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config;
})


export default axiosInstance;
