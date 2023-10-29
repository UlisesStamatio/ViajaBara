import { createRouter, createWebHistory } from "vue-router";
import SignupIllustration from "../views/auth/signup/Illustration.vue";
import Error404 from "../modules/auth/adapters/views/Error404.vue";
import Error500 from "../modules/auth/adapters/views/Error500.vue";
import Error403 from "../modules/auth/adapters/views/Error403.vue";
import ListUser from "../modules/users/adapters/views/ListUser.vue";
import NewUser from "../modules/users/adapters/views/NewUser.vue";
import UpdateUser from "../modules/users/adapters/views/UpdateUser.vue";
import ListMethod from "../modules/payment-methods/adapters/views/ListMethod.vue";
import NewMethod from "../modules/payment-methods/adapters/views/NewMethod.vue";
import UpdateMethod from "../modules/payment-methods/adapters/views/UpdateMethod.vue";
import ListBus from "../modules/buses/adapters/views/ListBus.vue";
import NewBus from "../modules/buses/adapters/views/NewBus.vue";
import UpdateBus from "../modules/buses/adapters/views/UpdateBus.vue";
import ListRoute from "../modules/routes/adapters/views/ListRoute.vue";
import NewRoute from "../modules/routes/adapters/views/NewRoute.vue";
import UpdateRoute from "../modules/routes/adapters/views/UpdateRoute.vue";
import ListTravel from "../modules/travels/adapters/views/ListTravel.vue";
import NewTravel from "../modules/travels/adapters/views/NewTravel.vue";
import UpdateTravel from "../modules/travels/adapters/views/UpdateTravel.vue";
import LandingPage from "../modules/auth/adapters/views/LandingPage.vue";
import Login from "../modules/auth/adapters/views/Login.vue"

const routes = [
  {
    path: "/",
    name: "/",
    redirect: "/inicio",
  },

  {
    path: "/signup",
    name: "Signup Illustration",
    component: SignupIllustration,
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
    name: "Registro Usuario",
    component: NewUser,
    meta: { requiresAuth: true }
  },
  {
    path: "/usuario/consultar/modificar",
    name: "Modificar Usuario",
    component: UpdateUser,
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
    name: "Registro Método",
    component: NewMethod,
    meta: { requiresAuth: true }
  },
  {
    path: "/metodo/consultar/modificar",
    name: "Modificar Método",
    component: UpdateMethod,
    meta: { requiresAuth: true }
  },
  {
    path: "/autobus/consultar",
    name: "Consultar Autobuses",
    component: ListBus,
    meta: { requiresAuth: true }
  },
  {
    path: "/autobus/registrar",
    name: "Registro Autobus",
    component: NewBus,
    meta: { requiresAuth: true }
  },
  {
    path: "/autobus/consultar/modificar",
    name: "Modificar Autobus",
    component: UpdateBus,
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
    name: "Registro Ruta",
    component: NewRoute,
    meta: { requiresAuth: true }
  },
  {
    path: "/ruta/consultar/modificar",
    name: "Modificar Ruta",
    component: UpdateRoute,
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
    name: "Registro Viaje",
    component: NewTravel,
    meta: { requiresAuth: true }
  },
  {
    path: "/viaje/consultar/modificar",
    name: "Modificar Viaje",
    component: UpdateTravel,
    meta: { requiresAuth: true }
  },
  {
    path: "/inicio",
    name: "Página Inicio",
    component: LandingPage,
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
