/**
=========================================================
* Vue Soft UI Dashboard PRO - v3.0.0
=========================================================
* Product Page: https://creative-tim.com/product/vue-soft-ui-dashboard-pro
* Copyright 2022 Creative Tim (https://www.creative-tim.com)
Coded by www.creative-tim.com
=========================================================
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*/

import { createApp } from "vue";
import App from "./App.vue";
import store from "./store";
import router from "./router";
import "./assets/css/nucleo-icons.css";
import "./assets/css/nucleo-svg.css";
import VueTilt from "vue-tilt.js";
import VueSweetalert2 from "vue-sweetalert2";
import VueAxios from "vue-axios";
import SoftUIDashboard from "./soft-ui-dashboard";
import axiosInstance from "./config/axios"
import VueGoogleMaps from '@fawmi/vue-google-maps';

const appInstance = createApp(App);
appInstance.use(store);
appInstance.use(router);
appInstance.use(VueTilt);
appInstance.use(VueSweetalert2);
appInstance.use(SoftUIDashboard);
appInstance.use(VueAxios, axiosInstance)
appInstance.use(VueGoogleMaps, {
    load:{
        key:  'AIzaSyCAdSIMc0pqLy4FIlPuedaAW3Tytc4-ULg',
    },
    autobindAllEvents: true,
})


appInstance.mount("#app");
