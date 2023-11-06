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
  <main class="mt-0 main-content">
    <section>
      <div class="page-header min-vh-100">
        <div class="container">
          <div class="row">
            <div
              class="mx-auto col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0"
            >
              <div class="card card-plain">
                <div class="pb-0 card-header text-start">
                  <h4 class="font-weight-bolder">Recuperar contraseña</h4>
                  <p class="mb-0">
                    Recibirás un correo en un máximo de 60 segundos.
                  </p>
                </div>
                <div class="card-body">
                  <form role="form">
                    <div class="mb-3">
                      <label>Correo electrónico</label>
                      <soft-input
                        type="email"
                        placeholder="Ingresa tu correo"
                        name="email"
                      />
                    </div>
                    <div class="text-center">
                      <soft-button
                        class="my-4"
                        variant="gradient"
                        color="primary"
                        full-width
                        size="lg"
                        >Enviar
                      </soft-button>
                    </div>
                  </form>
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
                    src="@/assets/img/illustrations/lock.png"
                    alt="lock-svg"
                  />
                </div>
                <h4 class="mt-5 text-white font-weight-bolder">
                  ViajaBara
                </h4>
                <p class="text-white">
                  Así como se necesita una empresa para sostener un producto, se necesita una comunidad para sostener un protocolo.
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
import SoftButton from "@/components/SoftButton.vue";

const body = document.getElementsByTagName("body")[0];
import { mapMutations } from "vuex";
export default {
  name: "ResetPassword",
  components: {
    Navbar,
    SoftInput,
    SoftButton,
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
