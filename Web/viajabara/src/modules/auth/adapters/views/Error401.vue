<template>
   <div class="container top-0 position-sticky z-index-sticky">
    <div class="row">
      <div class="col-12">
        <navbar
          is-blur="blur blur-rounded my-3 py-2 start-0 end-0 mx-4 shadow"
          btn-background="bg-gradient-danger"
          :dark-mode="true"
        />
      </div>
    </div>
  </div>
  <main class="main-content mt-0 ps">
    <div>
      <section class="min-vh-100 d-flex align-items-center">
        <div class="container">
          <div class="row mt-lg-0 mt-8">
            <div class="col-lg-5 my-auto">
              <h1
                class="display-1 text-bolder text-gradient text-danger fadeIn1 fadeInBottom mt-5"
              >
                Error 401
              </h1>
              <h2 class="fadeIn3 fadeInBottom opacity-8">
                Sin autorización
              </h2>
              <p class="lead opacity-6 fadeIn2 fadeInBottom">
                No tiene las credenciales necesarias para acceder al recurso solicitado.
              </p>
                  <router-link
                      :to="{ name: 'Página Inicio' }"
                      class="btn bg-gradient-danger fadeIn2 fadeInBottom"
                    >
                      Ir al inicio
                    </router-link>
            </div>
            <div class="col-lg-7 my-auto text-center">
              <img
                class="w-80 fadeIn1 fadeInBottom "
                src="../../../../assets/img/illustrations/error-403.png"
                alt="500-error"
              />
            </div>
          </div>
        </div>
      </section>
    </div>
    <div class="ps__rail-x" style="left: 0px; bottom: 0px">
      <div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px"></div>
    </div>
    <div class="ps__rail-y" style="top: 0px; right: 0px">
      <div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px"></div>
    </div>
  </main>
  <app-footer />
</template>
<script>
import Navbar from "@/examples/PageLayout/Navbar.vue";
import AppFooter from "@/examples/PageLayout/Footer.vue";

import { mapMutations } from "vuex";
export default {
  name: "Error401",
  components: {
    Navbar,
    AppFooter,
  },
  created() {
    this.toggleEveryDisplay();
    this.toggleHideConfig();
  },
  beforeUnmount() {
    this.toggleEveryDisplay();
    this.toggleHideConfig();
  },

  methods: {
    ...mapMutations(["toggleEveryDisplay", "toggleHideConfig"]),
  },
};
</script>
