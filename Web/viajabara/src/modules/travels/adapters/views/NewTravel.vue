<template>
  <div class="container-fluid">
    <div class="row">
      <div class="mx-auto col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row">
            <div class="col-4">
              <label>Conductor(<span class="text-danger">*</span>)</label>
              <select
                id="choices-category"
                class="form-control"
                name="choices-category"
              >
                <option value="Choice 1" >Michael Jackson Smith</option>
                <option value="Choice 2">Paula Rodríguez González</option>
                <option selected="">Selecciona una opción...</option>
              </select>
            </div>
            <div class="col-4">
              <label>Autobus(<span class="text-danger">*</span>)</label>
               <select
                id="choices-bus"
                class="form-control"
                name="choices-bus"
              >
                <option value="Choice 1" >23456789</option>
                <option value="Choice 2">23427789</option>
                <option selected="">Selecciona una opción...</option>
              </select>
            </div>
            <div class="col-4">
              <label>Ruta(<span class="text-danger">*</span>)</label>
              <select
                id="choices-route"
                class="form-control"
                name="choices-route"
              >
                <option value="Choice 1" >Cuernavaca - Jiutepec</option>
                <option value="Choice 2">Alpuyeca - Tres Marías</option>
                <option selected="">Selecciona una opción...</option>
              </select>
            </div>

            <div class="col-6 mt-4">
              <label>Fecha(<span class="text-danger">*</span>)</label>
              <soft-input
                id="usuario"
                type="datetime-local"
                placeholder=""
                name="surname"
                size=""
              />
            </div>


              <div class="col-6 mt-4">
              <label>Servicio(<span class="text-danger">*</span>)</label>
              <select
                  id="choices-service"
                  class="form-control"
                  name="choices-service"
                >
                  <option value="Choice 1" >Cuernavaca - Jiutepec</option>
                  <option value="Choice 2">Alpuyeca - Tres Marías</option>
                  <option selected="">Selecciona una opción...</option>
                </select>
            </div>


          </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">
              <soft-button
                type="button"
                color="secondary"
                variant="gradient"
                class="mb-0 me-2 ms-auto js-btn-next"
                title="Next"
                @click="this.$parent.nextStep"
                >Cancelar</soft-button>
              <soft-button
                type="button"
                color="dark"
                variant="gradient"
                class="mb-0 ms-auto js-btn-next"
                title="Next"
                @click="this.$parent.nextStep"
                >Crear Viaje</soft-button>
            </div>
          </div>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
import Quill from "quill";
import Choices from "choices.js";
// import UserInfo from "../../../../views/pages/Users/components/UserInfo.vue";
// import Address from "../../../../views/pages/Users/components/Address.vue";
// import Socials from "../../../../views/pages/Users/components/Socials.vue";
// import Profile from "../../../../views/pages/Users/components/Profile.vue";
import SoftInput from "@/components/SoftInput.vue";
import SoftButton from "@/components/SoftButton.vue";
export default {
  name: "NewUser",
  components: {
    // UserInfo,
    // Address,
    // Socials,
    // Profile,
    SoftInput,
    SoftButton
  },
  data() {
    return {
      showMenu: false,
      activeClass: "js-active position-relative",
      activeStep: 0,
      formSteps: 3,
    };
  },
  mounted() {
    if (document.getElementById("edit-description")) {
      // eslint-disable-next-line no-unused-vars
      var quill = new Quill("#edit-description", {
        theme: "snow", // Specify theme in configuration
      });
    }
    if (document.getElementById("choices-category")) {
      var element = document.getElementById("choices-category");
      new Choices(element, {
        searchEnabled: false,
      });
    }

    if (document.getElementById("choices-route")) {
      let element = document.getElementById("choices-route");
      new Choices(element, {
        searchEnabled: false,
      });
    }

     if (document.getElementById("choices-bus")) {
      let element = document.getElementById("choices-bus");
      new Choices(element, {
        searchEnabled: false,
      });
    }

     if (document.getElementById("choices-service")) {
      let element = document.getElementById("choices-service");
      new Choices(element, {
        searchEnabled: false,
      });
    }
  },
  methods: {
    nextStep() {
      if (this.activeStep < this.formSteps) {
        this.activeStep += 1;
      } else {
        this.activeStep -= 1;
      }
    },
    prevStep() {
      if (this.activeStep > 0) {
        this.activeStep -= 1;
      }
    },
  },
};
</script>
