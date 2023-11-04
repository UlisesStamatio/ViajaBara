<template>
<Loader :isLoading="isLoading"/>
  <div class="container-fluid" >
    <div class="row" >
      <div class="mx-auto col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row mx-5">
            <div class="col-12 mb-4">
              <label>Nombre:</label>
              <input 
                type="text"
                placeholder="eg. SeguridadEnLineaTotal"
                id="name"
                v-model="method.name"
                disabled
                class="form-control"
              >
            </div>
            <div class="col-12 mb-4">
              <label>API KEY:</label>
              <input 
                type="text"
                placeholder="eg. SeguridadEnLineaTotal"
                id="name"
                v-model="method.apikey"
                class="form-control"
                disabled
              >
            </div>
        </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">
              <button 
                type="button"
                class="mb-0 me-2 ms-auto btn js-btn-next bg-gradient-dark"
                title="Regresar"
                 @click="goBackPage"
                >
                  Regresar
                </button>
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
import router from '../../../../router/index'
import getMethod from '../../use-cases/get.method'
import Loader from '../../../../components/Loader.vue'

export default {
  name: "DetailMethod",
  components: {
    Loader,
  },
  data() {
    return {
      showMenu: false,
      activeClass: "js-active position-relative",
      activeStep: 0,
      formSteps: 3,
      method:{
        name: "",
        apikey: ""
      },
      idMethod:0,
      isLoading: false,
    };
  },
  async mounted() {
    this.idMethod = this.$route.params.id;
    await this.getMethod(this.idMethod);

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
     goBackPage(){
      this.method = {}
      this.errors = {}
      router.push({name: 'Consultar Métodos'})
    },
     async getMethod(id){
      this.isLoading = true;
      const response = {...await getMethod(id)};
      const {error, data} = response;
      this.isLoading = false;
        if(!error){
          const {result} = data
          this.method = result;
          this.methodOriginal = {...result}
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
  },
};
</script>
