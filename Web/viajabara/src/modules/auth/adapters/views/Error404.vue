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
    <section class="my-10">
      <div class="container">
        <div class="row">
          <div class="col-lg-6 my-auto">
            <h1 class="display-1 text-bolder text-gradient text-danger fadeIn2 fadeInBottom">
              Error 404
            </h1>
            <h2 class="fadeIn2 fadeInBottom">Recurso no encontrado</h2>
            <p class="lead fadeIn2 fadeInBottom">
              Le sugerimos que vaya a la página de inicio y lo intentes mas tarde.
            </p>
            <router-link
                      :to="{ name: 'Página Inicio' }"
                       class="btn bg-gradient-danger fadeIn2 fadeInBottom"
                    >
                      Ir al inicio
                    </router-link>
          </div>
          <div class="col-lg-6 my-auto position-relative text-center">
            <img
              class="w-100 position-relative fadeIn2 fadeInBottom"
              src="../../../../assets/img/illustrations/error-404.png"
              alt="404-error"
            />
          </div>
        </div>
      </div>
    </section>
  </main>
  <app-footer />
</template>

<script>
import Navbar from "@/examples/PageLayout/Navbar.vue";
import AppFooter from "@/examples/PageLayout/Footer.vue";


import { mapMutations } from "vuex";

export default {
  name: "SignupBasic",
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
