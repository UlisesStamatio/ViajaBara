<template>
  <Loader :isLoading="isLoading"/>
  <div class="container-fluid" >
    <form class="row" @submit.prevent="preUpdateMethod()">
      <div class="mx-auto col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row mx-5">
            <div class="col-12 mb-4">
              <label>Nombre(<span class="text-danger">*</span>)</label>
              <input 
                type="text"
                placeholder="eg. SeguridadEnLineaTotal"
                id="name"
                v-model="method.name"
                class="form-control"
                :class="{ 'is-invalid': errors.name, 'is-valid': errors.name === null }"
                maxlength="51"
              >
              <div class="invalid-feedback" v-if="errors.name">
                  {{ errors.name }}
              </div>
            </div>
            <div class="col-12 mb-4">
              <label>API KEY(<span class="text-danger">*</span>)</label>
              <input 
                type="text"
                placeholder="eg. SeguridadEnLineaTotal"
                id="name"
                v-model="method.apikey"
                class="form-control"
                :class="{ 'is-invalid': errors.apikey, 'is-valid': errors.apikey === null }"
                 maxlength="256"
              >
              <div class="invalid-feedback" v-if="errors.apikey">
                  {{ errors.apikey }}
              </div>
            </div>
        </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">
              <button 
                type="button"
                class="mb-0 me-2 ms-auto btn js-btn-next bg-gradient-secondary"
                title="Cancelar"
                 @click="goBackPage"
                >
                  Cancelar
                </button>

                <button 
                type="submit"
                class="mb-0 ms-auto btn js-btn-next bg-gradient-dark"
                title="Guardar"
                >
                  Guardar
                </button>
            </div>
          </div>
      </div>
    </div>
  </form>
  </div>
</template>

<script>
import Quill from "quill";
import Choices from "choices.js";
import methodValidator from '../../../../kernel/validators/method.validator'
import router from '../../../../router/index'
import updateMethod from '../../use-cases/update.method'
import getMethod from '../../use-cases/get.method'
import Loader from '../../../../components/Loader.vue'

export default {
  name: "NewMethod",
  components: {
    Loader
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
      errors:{
        name: "",
        apikey: ""
      },
      idMethod:0,
      methodOriginal: {},
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
   computed:{
    isFormModified(){
        for (const key in this.method) {
          if (this.method[key] !== this.methodOriginal[key]) {
              return true;
          }
        }
        return false;
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
    async preUpdateMethod(){
        let method = {...this.method};

        this.errors.name = methodValidator.validateName(method.name);
        this.errors.apikey = methodValidator.validateApiKey(method.apikey);
      if(this.isFormModified){
        if(!this.errors.name && !this.errors.apikey){
         this.$swal({
          title: "¿Estás segura(a) de guardar los cambios?",
          text: "¡No podrás revertir esto.!",
          icon: "warning",
          showCancelButton: true,
          cancelButtonText: "Cancelar",
          confirmButtonText: "Confirmar",
          customClass: {
            confirmButton: "btn bg-gradient-success",
            cancelButton: "btn bg-gradient-secondary",
          },
          buttonsStyling: false,
        }).then(async(result) => {
          if (result.isConfirmed) {
              method.id = this.idMethod 
              this.isLoading = true;
              const {message, error, data} = await updateMethod(method)
              this.isLoading = false;
              if(!error){
                const {result:{text}} = data
                this.$swal({
                  icon: "success",
                  title: message,
                  text: text,
                  type: 'success-message',
                });
                router.push({name: 'Consultar Métodos'})
              }else{
                const {text} = data
                this.$swal({
                    icon: "error", 
                    title: message,
                    text: text,
                    type: "basic",
                  });
              }
          } else if (result.dismiss === this.$swal.DismissReason.cancel) {
            this.$swal.dismiss;
          }})
        }
      }else{
        this.$swal({
          icon: "info", 
          title: 'No has realizado ninguna modificación.',
          type: "basic",
        });
      }
    }
  },
};
</script>
