<template>
  <div
    id="sidenav-collapse-main"
    class="w-auto h-auto collapse navbar-collapse max-height-vh-100 h-100"
  >
    <ul class="navbar-nav">
      
      <li class="mt-3 nav-item">
        <h6
          class="text-xs ps-4 text-uppercase font-weight-bolder opacity-6"
          :class="isRTL ? 'me-4' : 'ms-2'"
        >
          PÁGINAS
        </h6>
      </li>
      <li class="nav-item">
        <sidenav-collapse
          collapse-ref="userExamples"
          nav-text="Usuarios"
          :class="getRoute() === 'usuario' ? 'active' : ''"
        >
          <template #icon>
            <User />
          </template>
          <template #list>
            <ul class="nav ms-4 ps-3">
              <!-- nav links -->
              <sidenav-item
                :to="{ name: 'Consultar Usuarios' }"
                mini-icon="S"
                text="Consultar"
              />
              <sidenav-item
                :to="{ name: 'Registrar Usuario' }"
                mini-icon="N"
                text="Registrar"
              />
            </ul>
          </template>
        </sidenav-collapse>
      </li>

      <li class="nav-item">
        <sidenav-collapse
          collapse-ref="methodsExamples"
          nav-text="Métodos de pago"
          :class="getRoute() === 'metodo' ? 'active' : ''"
        >
          <template #icon>
            <CreditCard />
          </template>
          <template #list>
            <ul class="nav ms-4 ps-3">
              <!-- nav links -->

              <sidenav-item
                :to="{ name: 'Consultar Métodos' }"
                mini-icon="P"
                text="Consultar"
              />
              <sidenav-item
                :to="{ name: 'Registrar Método' }"
                mini-icon="W"
                text="Registrar"
              />
            </ul>
          </template>
        </sidenav-collapse>
      </li>

      <li class="nav-item">
        <sidenav-collapse
          collapse-ref="unitsExamples"
          nav-text="Unidades"
          :class="getRoute() === 'unidad' ? 'active' : ''"
        >
          <template #icon>
            <Bus />
          </template>
          <template #list>
            <ul class="nav ms-4 ps-3">
              <!-- nav links -->

              <sidenav-item
                :to="{ name: 'Consultar Unidades' }"
                mini-icon="P"
                text="Consultar"
              />
              <sidenav-item
                :to="{ name: 'Registrar Unidad' }"
                mini-icon="W"
                text="Registrar"
              />
            </ul>
          </template>
        </sidenav-collapse>
      </li>

      <li class="nav-item">
        <sidenav-collapse
          collapse-ref="routeExamples"
          nav-text="Rutas"
          :class="getRoute() === 'ruta' ? 'active' : ''"
        >
          <template #icon>
            <Route />
          </template>
          <template #list>
            <ul class="nav ms-4 ps-3">
              <!-- nav links -->
              <sidenav-item
                :to="{ name: 'Consultar Rutas' }"
                mini-icon="P"
                text="Consultar"
              />
               <sidenav-item
                :to="{ name: 'Registrar Ruta' }"
                mini-icon="W"
                text="Registrar"
              />
            </ul>
          </template>
        </sidenav-collapse>
      </li>


      <li class="nav-item">
        <sidenav-collapse
          collapse-ref="travelExamples"
          nav-text="Viajes"
          :class="getRoute() === 'viaje' ? 'active' : ''"
        >
          <template #icon>
            <Travel />
          </template>
          <template #list>
            <ul class="nav ms-4 ps-3">
              <!-- nav links -->
              <sidenav-item
                :to="{ name: 'Consultar Viajes' }"
                mini-icon="P"
                text="Consultar"
              />
              <sidenav-item
                :to="{ name: 'Registrar Viaje' }"
                mini-icon="W"
                text="Registrar"
              />
            </ul>
          </template>
        </sidenav-collapse>
      </li>

    </ul>
  </div>
</template>
<script>
import SidenavItem from "./SidenavItem.vue";
import SidenavCollapse from "./SidenavCollapse.vue";
//import SidenavCard from "./SidenavCard.vue";
//import SidenavCollapseItem from "./SidenavCollapseItem.vue";
//import Settings from "../../components/Icon/Settings.vue";
import Bus from "../../components/Icon/Bus.vue";
//import Box3d from "../../components/Icon/Box3d.vue";
//import Shop from "../../components/Icon/Shop.vue";
//import Office from "../../components/Icon/Office.vue";
//import Document from "../../components/Icon/Document.vue";
import User from "../../components/Icon/User.vue";
//import Spaceship from "../../components/Icon/Spaceship.vue";
import CreditCard from "../../components/Icon/CreditCard.vue";
import Route from "../../components/Icon/Route.vue";
import Travel from "../../components/Icon/Travel.vue";

import { mapState } from "vuex";
export default {
  name: "SidenavList",
  components: {
    SidenavItem,
    SidenavCollapse,
    //SidenavCard,
    //SidenavCollapseItem,
    //Settings,
    Bus,
    Route,
    Travel,
    //Box3d,
   // Shop,
    //Office,
    //Document,
    User,
    //Spaceship,
    CreditCard,
  },
  props: {
    cardBg: {
      type: String,
      default: "",
    },
  },
    computed: {
      ...mapState(["isRTL"]),
    },
  methods: {
    getRoute() {
      const routeArr = this.$route.path.split("/");
      return routeArr[1];
    },
  },
};
</script>
