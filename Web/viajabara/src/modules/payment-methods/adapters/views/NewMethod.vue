<template>
  <Loader :isLoading="isLoading"/>
  <div class="container-fluid" v-show="!isLoading">
    <form class="row" @submit.prevent="preNewMethod()">
      <div class="mx-auto col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row mx-5">
            <div class="col-12 mb-4">
              <label>Nombre(<span class="text-danger">*</span>)</label>
              <input 
                type="text"
                placeholder="eg. crédito"
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
                placeholder="eg. zaxhsgatwafshsfghafghagsagsfaf"
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
                title="Crear método"
                >
                  Crear método
                </button>
            </div>
          </div>
      </div>
    </div>
  </form>
  </div>
</template>

<script>
import methodValidator from '../../../../kernel/validators/method.validator'
import router from '../../../../router/index'
import newMethod from '../../use-cases/new.method'
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
      isLoading: false,
    };
  },
  mounted() {
    
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
    async preNewMethod(){
        let method = {...this.method};

        this.errors.name = methodValidator.validateName(method.name);
        this.errors.apikey = methodValidator.validateApiKey(method.apikey);

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
              this.isLoading = true;
              const {message, error, data} = await newMethod(method)
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
    }
  },
};
</script>
