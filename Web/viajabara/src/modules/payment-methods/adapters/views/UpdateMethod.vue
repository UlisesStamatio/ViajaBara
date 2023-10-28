<template>
  <div class="container-fluid">
    <div class="row">
      <div class="mx-auto col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row mx-5">
            <div class="col-12">
              <label>Nombre(<span class="text-danger">*</span>)</label>
              <soft-input
                id="name"
                type="text"
                placeholder="eg. SeguridadEnLineaTotal"
                name="name"
                size=""
                value="SeguridadEnLineaTotal"
              />
            </div>
            <div class="col-12">
              <label>API KEY(<span class="text-danger">*</span>)</label>
              <soft-input
                id="lastname"
                type="text"
                placeholder="eg. xjhjha27shghzg216tr1263hgsayg62tvw"
                name="lastname"
                size=""
                value="xjhjha27shghzg216tr1263hgsayg62tvw"
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
  name: "UpdateMethod",
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
