<template>
  <Loader :isLoading="isLoading"/>
  <div class="container top-0 position-sticky z-index-sticky" v-show="!isLoading">
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
  <main class="mt-0 main-content" v-show="!isLoading">
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
                  <form class="row g-3 needs-validation" novalidate @submit.prevent="prerecover" >
                    <div class="col-12 mb-1">
                      <label>Correo</label>
                      <div class="input-group has-validation">
                        <input type="email" v-model="form.email" class="form-control" :class="{ 'is-invalid': errors.email, 'is-valid': errors.email === null }" 
                        placeholder="Ingresa tu correo" required/> 
                        <div class="invalid-feedback" v-if="errors.email">
                          {{ errors.email }}
                        </div>
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="mt-4 btn btn-lg bg-gradient-danger w-100">Enviar</button>
                    </div>

                  </form>
                </div>
              </div>
            </div>
            <div
              class="top-0 my-auto text-center col-6 d-lg-flex d-none h-100 pe-0 position-absolute end-0 justify-content-center flex-column"
            >
              <div
                class="m-3 position-relative bg-gradient-danger h-100 px-7 border-radius-lg d-flex flex-column justify-content-center"
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
import Validations from "../../../../kernel/validators/autoregister.validator"
import Recover from '../../use-cases/recover'
import router from '../../../../router/index'
import Loader from '../../../../components/Loader.vue'

const body = document.getElementsByTagName("body")[0];
import { mapMutations } from "vuex";
export default {
  name: "ResetPassword",
  components: {
    Navbar,
    Loader
  },
  data(){
    return{
      form:{
      email: "",
      },
      errors:{
        email: "",
      },
      isLoading:false,
    }
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
    prerecover(){
      this.errors.email = Validations.validateEmail(this.form.email);

      if(!this.errors.email){
         this.$swal({
          title: "¿Estás seguro(a) de enviar el correo?",
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
              const {message, error, data} = await Recover(this.form)
              if(!error){
                this.isLoading = false;
                const {result:{text}} = data
                this.$swal({
                  icon: "success",
                  title: message,
                  text: text,
                  type: 'success-message',
                });
                setTimeout(()=>{
                 router.push({name: 'Cambiar Password'})
                }, 2000)
              }else{
                this.isLoading = false;
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
          }
        });
      }
    },
    ...mapMutations(["toggleEveryDisplay", "toggleHideConfig"]),
  },
};
</script>
