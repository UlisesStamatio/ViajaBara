<template>
  <div class="container top-0 position-sticky z-index-sticky">
    <div class="row">
      <div class="col-12">
        <navbar
          is-blur="blur blur-rounded my-3 py-2 start-0 end-0 mx-4 shadow"
          btn-background="bg-gradient-primary"
          :dark-mode="true"
        />
      </div>
    </div>
  </div>
  <main class="mt-2 main-content">
    <section>
      <div class="page-header min-vh-100">
        <div class="container">
          <div class="row">
            <div
              class="mx-auto col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0"
            >
              <div class="card card-plain">
                <div class="pb-0 card-header text-start">
                  <h4 class="font-weight-bolder">Iniciar sesión</h4>
                  <p class="mb-0">Ingresa tu usuario y contraseña para iniciar sesión.</p>
                </div>
                <div class="card-body">
                  <form role="form">
                    <div class="mb-3">
                      <label>Usuario</label>
                      <soft-input
                        id="usuario"
                        type="text"
                        placeholder="Ingresa tu usuario"
                        name="Usuario"
                        size="lg"
                      />
                    </div>
                    <div class="mb-3">
                      <label>Contraseña</label>
                      <soft-input
                        id="password"
                        type="password"
                        placeholder=""
                        name="Contraseña"
                        size="lg"
                      />
                    </div>
                    <soft-switch id="rememberMe" name="rememberMe">
                      Recordar
                    </soft-switch>

                    <div class="text-center">
                      <router-link
                        :to="{ name: 'Consultar Usuarios' }"
                        class="mt-4 btn btn-lg bg-gradient-primary w-100"
                        >Iniciar sesión
                      </router-link>
                    </div>
                  </form>
                </div>
                <div class="px-1 pt-0 text-center card-footer px-lg-2">
                  <p class="mx-auto mb-4 text-sm">
                    ¿No tienes una cuenta? 
                    <router-link
                      :to="{ name: 'Signup Illustration' }"
                      class=" font-weight-bold"
                    >
                      Registrarse
                    </router-link>
                  </p>
                </div>
              </div>
            </div>
            <div
              class="top-0 my-auto text-center col-6 d-lg-flex d-none h-100 pe-0 position-absolute end-0 justify-content-center flex-column"
            >
              <div
                class="m-3 position-relative bg-gradient-primary h-100 px-7 border-radius-lg d-flex flex-column justify-content-center"
              >
                <img
                  src="@/assets/img/shapes/pattern-lines.svg"
                  alt="pattern-lines"
                  class="position-absolute opacity-4 start-0"
                />
                <div class="position-relative">
                  <img
                    class="max-width-500 w-100 position-relative z-index-2"
                    src="@/assets/img/illustrations/chat.png"
                    alt="chat-img"
                  />
                </div>
                <h4 class="mt-5 text-white font-weight-bolder">
                  La atención es la nueva moneda
                </h4>
                <p class="text-white">
                 Cuanto más sencilla parece la escritura, más esfuerzo pone el escritor en el proceso.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script>
import Navbar from "@/examples/PageLayout/Navbar.vue";
import SoftInput from "@/components/SoftInput.vue";
import SoftSwitch from "@/components/SoftSwitch.vue";
//import SoftButton from "@/components/SoftButton.vue";
const body = document.getElementsByTagName("body")[0];

import { mapMutations } from "vuex";
export default {
  name: "SigninIllustration",
  components: {
    Navbar,
    SoftInput,
    SoftSwitch,
    //SoftButton,
  },

  created() {
    this.toggleEveryDisplay();
    this.toggleHideConfig();
    body.classList.remove("bg-gray-100");
  },
  beforeUnmount() {
    this.toggleEveryDisplay();
    this.toggleHideConfig();
    body.classList.add("bg-gray-100");
  },
  methods: {
    ...mapMutations(["toggleEveryDisplay", "toggleHideConfig"]),
  },
};
</script>
