<template>
  <div class="container-fluid">
    <div class="row">
      <div class="mx-auto col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row">
            <div class="col-4">
              <label>Nombre(<span class="text-danger">*</span>)</label>
              <soft-input
                id="name"
                type="text"
                placeholder="eg. Michael"
                name="name"
                size=""
                value="Michael"
              />
            </div>
            <div class="col-4">
              <label>Apellido Paterno(<span class="text-danger">*</span>)</label>
              <soft-input
                id="lastname"
                type="text"
                placeholder="eg. Jackson"
                name="lastname"
                size=""
                value="Jackson"
              />
            </div>
            <div class="col-4">
              <label>Apellido Materno</label>
              <soft-input
                id="usuario"
                type="text"
                placeholder="eg. Smith"
                name="surname"
                size=""
                value="Smith"
              />
            </div>

            <div class="col-3">
              <label>Sexo(<span class="text-danger">*</span>)</label>
              <select
                id="choices-category"
                class="form-control"
                name="choices-category"
              >
                <option value="Choice 1"  selected="">Masculino</option>
                <option value="Choice 2">Femenino</option>
                <option>Selecciona una opción...</option>
              </select>
            </div>

            <div class="col-3">
              <label>Fecha de nacimiento(<span class="text-danger">*</span>)</label>
             <soft-input
                id="usuario"
                type="date"
                placeholder="eg. Smith"
                name="surname"
                size=""
                value="2002-10-20"
              />
            </div>

              <div class="col-3">
              <label>Télefono(<span class="text-danger">*</span>)</label>
             <soft-input
                id="usuario"
                type="text"
                placeholder="eg. 76568788787"
                name="surname"
                size=""
                value="76568788787"
              />
            </div>

              <div class="col-3">
              <label>Estado de residencia(<span class="text-danger">*</span>)</label>
              <select
                id="choices-sizes"
                class="form-control"
                name="choices-sizes"
              >
                <option value="Choice 1" selected="">Morelos</option>
                <option value="Choice 2">CDMX</option>
                <option >Selecciona una opción...</option>
              </select>
            </div>

              <div class="col-6">
              <label>Correo(<span class="text-danger">*</span>)</label>
              <soft-input
                id="email"
                type="email"
                placeholder="eg. example@address.com"
                name="email"
                size=""
                value="example@address.com"
              />
            </div>

            <div class="col-6">
              <label>Confirmar correo(<span class="text-danger">*</span>)</label>
              <soft-input
                id="email"
                type="email"
                placeholder="eg. example@address.com"
                name="email"
                size=""
                value="example@address.com"
              />
            </div>


          </div>
           <h6 class="mt-3">Datos de identificación</h6>
          <hr class="mt-2 horizontal dark" />

          <div class="row">
              <div class="col-6">
              <label>Usuario(<span class="text-danger">*</span>)</label>
              <soft-input
                id="username"
                type="text"
                placeholder="eg. MichaelJack"
                name="username"
                size=""
                value="MichaelJack"
              />
              </div>

              <div class="col-6">
              <label>RFC(<span class="text-danger">*</span>)</label>
              <soft-input
                id="rfc"
                type="text"
                placeholder="eg. MIDE234512SD2"
                name="rfc"
                size=""
                value="MIDE234512SD2"
              />
              </div>

               <div class="col-6">
              <label>Contraseña(<span class="text-danger">*</span>)</label>
              <soft-input
                id="password"
                type="password"
                placeholder="****************"
                name="password"
                size=""
                value="MichaelJack"
              />
              </div>

              <div class="col-6">
              <label>Confirmar contraseña(<span class="text-danger">*</span>)</label>
              <soft-input
                id="confirmpassword"
                type="password"
                placeholder="****************"
                name="confirmpassword"
                size=""
                value="MichaelJack"
              />
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
                >Guardar</soft-button>
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
  name: "UpdateUser",
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

    if (document.getElementById("choices-sizes")) {
      let element = document.getElementById("choices-sizes");
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
