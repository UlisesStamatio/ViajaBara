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
              class="mx-auto col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mt-5"
            >
              <div class="card card-plain">
                <div class="pb-0 card-header text-start">
                  <h4 class="font-weight-bolder">Cambiar contraseña</h4>
                  <p class="mb-0">
                    Recibirás un correo en un máximo de 60 segundos.
                  </p>
                </div>
                <div class="card-body">
                  <form class="row g-3 needs-validation" novalidate @submit.prevent="prechangepassword" >
                    <div class="col-12 ">
                      <label>Correo</label>
                      <div class="input-group has-validation">
                          <input type="email" v-model="form.email" class="form-control" :class="{ 'is-invalid': errors.email, 'is-valid': errors.email === null }" 
                          placeholder="Ingresa tu correo" required/> 
                          <div class="invalid-feedback" v-if="errors.email">
                            {{ errors.email }}
                          </div>
                      </div>
                    </div>
                    <div class="col-12 mt-3">
                      <label>Código</label>
                      <div class="input-group has-validation">
                          <input type="text" v-model="form.code" class="form-control" :class="{ 'is-invalid': errors.code, 'is-valid': errors.code === null }" 
                          placeholder="Ingresa tu correo" required/> 
                          <div class="invalid-feedback" v-if="errors.code">
                            {{ errors.code }}
                          </div>
                      </div>
                    </div>
                    
                    <div class="col-12 mt-3 ">  
                      <label>Contraseña nueva</label>
                          <div class="input-group flex-nowrap">
                            <input
                            :type="showPassword ? 'text' : 'password'" 
                            class="form-control" 
                            placeholder="Ingresa tu contraseña" 
                            id="password-input"  
                            v-model="form.password"
                            :class="{ 'is-invalid': errors.password, 'is-valid': errors.password === null }"
                            />
                            <span class="input-group-text" id="password-input" @click="togglePasswordVisibility" style="cursor:pointer;">
                              <i class="fas" :class="showPassword ?  'fa-eye' : 'fa-eye-slash' "></i>
                            </span>
                        </div>
                         <div style="font-size: 0.875em; color: #fd5c70;" v-if="errors.password">
                          {{ errors.password }}
                        </div>
                    </div>

                     <div class=" col-12 mb-3">  
                      <label>Confirmar contraseña</label>
                          <div class="input-group flex-nowrap">
                            <input
                            :type="showConfirmPassword ? 'text' : 'password'" 
                            class="form-control" 
                            placeholder="Ingresa tu contraseña" 
                            id="password-input"  
                            v-model="form.confirmPassword"
                            :class="{ 'is-invalid': errors.confirmPassword, 'is-valid': errors.confirmPassword === null }"
                            />
                            <span class="input-group-text" id="password-input" @click="toggleConfirmPasswordVisibility" style="cursor:pointer;">
                              <i class="fas" :class="showConfirmPassword ?  'fa-eye' : 'fa-eye-slash' "></i>
                            </span>
                        </div>
                         <div style="font-size: 0.875em; color: #fd5c70;" v-if="errors.confirmPassword">
                          {{ errors.confirmPassword }}
                        </div>
                    </div>


                    <div class="text-center">
                      <button type="submit" class="mt-4 btn btn-lg bg-gradient-danger w-100">Cambiar</button>
                    </div>

                  </form>
                </div>
              </div>
            </div>
            <div
              class=" mt-5 top-0 my-auto text-center col-6 d-lg-flex d-none h-100 pe-0 position-absolute end-0 justify-content-center flex-column"
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
import changePassword from '../../use-cases/change.password'
import router from '../../../../router/index'
import Loader from '../../../../components/Loader.vue'

const body = document.getElementsByTagName("body")[0];
import { mapMutations } from "vuex";
export default {
  name: "ChangePassword",
  components: {
    Navbar,
    Loader,
  },
  data(){
    return{
      form:{
        email: "",
        code: "",
        password: "",
        confirmPassword: "",
      },
      errors:{
       email: "",
        code: "",
        password: "",
        confirmPassword: "",
      },
      showPassword: false,
      showConfirmPassword: false,
      isLoading: false,
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
    prechangepassword(){
      this.errors.email = Validations.validateEmail(this.form.email);
      this.errors.code = Validations.validateCode(this.form.code);
      this.errors.password = Validations.validatePassword(this.form.password);  
      this.errors.confirmPassword = Validations.validateConfirmPassword(this.form.password, this.form.confirmPassword);  

      if(!this.errors.email && ! this.errors.code && !this.errors.password
         && !this.errors.confirmPassword ){

          let payload = {
            email: this.form.email,
            recuperation: this.form.code,
            password: this.form.password
          }

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
              const {message, error, data} = await changePassword(payload)
              this.isLoading = false;
              if(!error){
                const {result:{text}} = data
                this.$swal({
                  icon: "success",
                  title: message,
                  text: text,
                  type: 'success-message',
                });
                setTimeout(()=>{
                 router.push({name: 'Signin Illustration'})
                }, 2000)
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
          }
        });
      }
    },
    togglePasswordVisibility(){
      this.showPassword = !this.showPassword;
    },
    toggleConfirmPasswordVisibility(){
      this.showConfirmPassword = !this.showConfirmPassword;
    },
    ...mapMutations(["toggleEveryDisplay", "toggleHideConfig"]),
  },
};
</script>
