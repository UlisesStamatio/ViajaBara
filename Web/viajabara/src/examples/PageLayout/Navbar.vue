<template>
  <!-- Navbar -->
  <nav
    class="sticky-top top-0 navbar navbar-expand-lg position-absolute z-index-3"
    :class="isBlur ? isBlur : 'shadow-none my-2 navbar-transparent w-100'"
  >
    <div class="container">
      <router-link
        class="navbar-brand font-weight-bolder ms-lg-0 ms-3"
        :class="darkMode ? 'text-black' : 'text-white'"
        to="/"
        >ViajaBara</router-link>
      <button
        class="shadow-none navbar-toggler ms-2"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navigation"
        aria-controls="navigation"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="mt-2 navbar-toggler-icon">
          <span class="navbar-toggler-bar bar1"></span>
          <span class="navbar-toggler-bar bar2"></span>
          <span class="navbar-toggler-bar bar3"></span>
        </span>
      </button>
      <div
        id="navigation"
        class="pt-3 pb-2 collapse navbar-collapse w-100 py-lg-0"
      >
        <ul class="mx-auto navbar-nav navbar-nav-hover">
          <li class="mx-2 nav-item dropdown dropdown-hover">
            <a
              :href="'/inicio#home'"
              class="cursor-pointer nav-link ps-2 d-flex justify-content-between align-items-center"
              :class="[darkModes]"
            >
              Inicio
            </a>
          </li>
          <li class="mx-2 nav-item dropdown dropdown-hover">
            <a
              :href="'/inicio#who'"
              class="cursor-pointer nav-link ps-2 d-flex justify-content-between align-items-center"
              :class="[darkModes]"
            >
              ¿Quiénes somos?
            </a>
          </li>
          <li class="mx-2 nav-item dropdown dropdown-hover">
            <a
              :href="'/inicio#route'"
              class="cursor-pointer nav-link ps-2 d-flex justify-content-between align-items-center"
              :class="[darkModes]"
            >
              Ruta actual
            </a>
          </li>
          <li class="mx-2 nav-item dropdown dropdown-hover">
            <a
              :href="'/inicio#services'"
              class="cursor-pointer nav-link ps-2 d-flex justify-content-between align-items-center"
              :class="[darkModes]"
            >
              Servicios adicionales
            </a>
          </li>
          <li class="mx-2 nav-item dropdown dropdown-hover">
            <a
              :href="'/inicio#quotes'"
              class="cursor-pointer nav-link ps-2 d-flex justify-content-between align-items-center"
              :class="[darkModes]"
            >
              Cotiza tu viaje
            </a>
          </li>

            <li class="mx-2 nav-item dropdown dropdown-hover">
            <a
              :href="'/inicio#contact'"
              class="cursor-pointer nav-link ps-2 d-flex justify-content-between align-items-center"
              :class="[darkModes]"
            >
              Contáctanos
            </a>
          </li>
        </ul>
        <ul class="navbar-nav d-lg-block d-none">
          <li class="nav-item">
            <router-link
              :to="{ name: 'Signin Illustration' }"
              class="mb-0 btn btn-sm btn-round me-1"
              :class="btnBackground ? btnBackground : 'bg-white'"
              onclick="smoothToPricing('pricing-soft-ui')"
              >Iniciar sesión
              </router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- End Navbar -->
</template>

<script>
/*eslint-disable*/
import downArrWhite from "@/assets/img/down-arrow-white.svg";
import downArrBlack from "@/assets/img/down-arrow-dark.svg";
import Office from "../../components/Icon/Office.vue";
import Shop from "../../components/Icon/Shop.vue";
import CustomerSupport from "../../components/Icon/CustomerSupport.vue";
import Document from "../../components/Icon/Document.vue";
import Spaceship from "../../components/Icon/Spaceship.vue";
import GettingStarted from "../../components/Icon/GettingStarted.vue";
import Box3d from "../../components/Icon/Box3d.vue";
import Settings from "../../components/Icon/Settings.vue";

export default {
  name: "NavbarAnonimous",
  components: {
    Office,
    Shop,
    CustomerSupport,
    Document,
    Spaceship,
    GettingStarted,
    Box3d,
    Settings
  },
  props: {
    btnBackground: {
      type: String,
      default: "",
    },
    isBlur: {
      type: String,
      default: "",
    },
    darkMode: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      downArrWhite,
      downArrBlack
    };
  },
  computed: {
    darkModes() {
      return {
        "text-dark": this.darkMode
      };
    }
  }
};
</script>
