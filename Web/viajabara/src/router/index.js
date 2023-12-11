import { createRouter, createWebHistory } from "vue-router";
import Autoregister from "../modules/auth/adapters/views/Autoregister.vue";

import Error404 from "../modules/auth/adapters/views/Error404.vue";
import Error500 from "../modules/auth/adapters/views/Error500.vue";
import Error403 from "../modules/auth/adapters/views/Error403.vue";
import Profile from "../modules/auth/adapters/views/Profile.vue";
import ListUser from "../modules/users/adapters/views/ListUser.vue";
import NewUser from "../modules/users/adapters/views/NewUser.vue";
import UpdateUser from "../modules/users/adapters/views/UpdateUser.vue";
import DetailUser from "../modules/users/adapters/views/DetailUser.vue";
import ListMethod from "../modules/payment-methods/adapters/views/ListMethod.vue";
import NewMethod from "../modules/payment-methods/adapters/views/NewMethod.vue";
import UpdateMethod from "../modules/payment-methods/adapters/views/UpdateMethod.vue";
import DetailMethod from "../modules/payment-methods/adapters/views/DetailMethod.vue";
import ListBus from "../modules/buses/adapters/views/ListBus.vue";
import NewBus from "../modules/buses/adapters/views/NewBus.vue";
import UpdateBus from "../modules/buses/adapters/views/UpdateBus.vue";
import DetailBus from "../modules/buses/adapters/views/DetailBus.vue";
import ListRoute from "../modules/routes/adapters/views/ListRoute.vue";
import NewRoute from "../modules/routes/adapters/views/NewRoute.vue";
import UpdateRoute from "../modules/routes/adapters/views/UpdateRoute.vue";
import DetailRoute from "../modules/routes/adapters/views/DetailRoute.vue";
import ListTravel from "../modules/travels/adapters/views/ListTravel.vue";
import NewTravel from "../modules/travels/adapters/views/NewTravel.vue";
import UpdateTravel from "../modules/travels/adapters/views/UpdateTravel.vue";
import DetailTravel from "../modules/travels/adapters/views/DetailTravel.vue";
import LandingPage from "../modules/auth/adapters/views/LandingPage.vue";
import Login from "../modules/auth/adapters/views/Login.vue"
import ResetPassword from "../modules/auth/adapters/views/ResetPassword.vue"

const routes = [
  {
    path: "/",
    name: "/",
    redirect: "/inicio#home",
  },

  {
    path: "/autoregistro",
    name: "Auto Registro",
    component: Autoregister,
  },
  {
    path: "/error404",
    name: "Error Error404",
    component: Error404,
  },
  {
    path: "/error500",
    name: "Error Error500",
    component: Error500,
  },
  {
    path: "/error403",
    name: "Error Error403",
    component: Error403,
  },
  {
    path: "/login",
    name: "Signin Illustration",
    component: Login,
  },
  {
    path: "/usuario/consultar",
    name: "Consultar Usuarios",
    component: ListUser,
    meta: { requiresAuth: true }
  },
  {
    path: "/usuario/registrar",
    name: "Registrar Usuario",
    component: NewUser,
    meta: { requiresAuth: true }
  },
  {
    path: "/usuario/consultar/modificar/:id",
    name: "Modificar Usuario",
    component: UpdateUser,
    meta: { requiresAuth: true }
  },
  {
    path: "/usuario/consultar/visualizar/:id",
    name: "Visualizar Usuario",
    component: DetailUser,
    meta: { requiresAuth: true }
  },
  {
    path: "/perfil",
    name: "Gestionar Perfil",
    component: Profile,
    meta: { requiresAuth: true }
  },
  {
    path: "/metodo/consultar",
    name: "Consultar Métodos",
    component: ListMethod,
    meta: { requiresAuth: true }
  },
  {
    path: "/metodo/registrar",
    name: "Registrar Método",
    component: NewMethod,
    meta: { requiresAuth: true }
  },
  {
    path: "/metodo/consultar/modificar/:id",
    name: "Modificar Método",
    component: UpdateMethod,
    meta: { requiresAuth: true }
  },
  {
    path: "/metodo/consultar/visualizar/:id",
    name: "Visualizar Método",
    component: DetailMethod,
    meta: { requiresAuth: true }
  },
  {
    path: "/unidad/consultar",
    name: "Consultar Unidades",
    component: ListBus,
    meta: { requiresAuth: true }
  },
  {
    path: "/unidad/registrar",
    name: "Registrar Unidad",
    component: NewBus,
    meta: { requiresAuth: true }
  },
  {
    path: "/unidad/consultar/modificar/:id",
    name: "Modificar Unidad",
    component: UpdateBus,
    meta: { requiresAuth: true }
  },
  {
    path: "/unidad/consultar/visualizar/:id",
    name: "Visualizar Unidad",
    component: DetailBus,
    meta: { requiresAuth: true }
  },
  {
    path: "/ruta/consultar",
    name: "Consultar Rutas",
    component: ListRoute,
    meta: { requiresAuth: true }
  },
  {
    path: "/ruta/registrar",
    name: "Registrar Ruta",
    component: NewRoute,
    meta: { requiresAuth: true }
  },
  {
    path: "/ruta/consultar/modificar/:id",
    name: "Modificar Ruta",
    component: UpdateRoute,
    meta: { requiresAuth: true }
  },
  {
    path: "/ruta/consultar/visualizar/:id",
    name: "Visualizar Ruta",
    component: DetailRoute,
    meta: { requiresAuth: true }
  },
  {
    path: "/viaje/consultar",
    name: "Consultar Viajes",
    component: ListTravel,
    meta: { requiresAuth: true }
  },
  {
    path: "/viaje/registrar",
    name: "Registrar Viaje",
    component: NewTravel,
    meta: { requiresAuth: true }
  },
  {
    path: "/viaje/consultar/modificar/:id",
    name: "Modificar Viaje",
    component: UpdateTravel,
    meta: { requiresAuth: true }
  },
  {
    path: "/viaje/consultar/visualizar/:id",
    name: "Visualizar Viaje",
    component: DetailTravel,
    meta: { requiresAuth: true }
  },
  {
    path: "/inicio",
    name: "Página Inicio",
    component: LandingPage,
  },
  {
    path: "/recuperar",
    name: "Recuperar Contraseña",
    component: ResetPassword,
  },
  
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
  linkActiveClass: "active",
});

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('session');
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!token) {

      next('/login');
    } else {
      if (to.path === '/login' && token) {
        next('/usuario/consultar');
      } else {
        next();
      }
    }
  } else {
    // Las rutas que no requieren autenticación se dejan pasar libremente
    if (to.path === '/login' && token) {
      next('/usuario/consultar');
    } else {
      next();
    }
  }
});

export default router;
