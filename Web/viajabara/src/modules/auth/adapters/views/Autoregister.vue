<template>
  <div class="container top-0 position-sticky z-index-sticky">
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
  <main class="mt-4 main-content">
    <section>
      <div class="page-header min-vh-100">
        <div class="container">
          <div class="row">
            <div
              class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto mt-3"
            >
              <div class="card card-plain">
                <div class="card-header pb-0 text-left">
                  <h4 class="font-weight-bolder">Registrarse</h4>
                  <p class="mb-0">Ingresa los siguientes datos para registrarte</p>
                </div>
                <div class="card-body pb-3">
                  <form class="row g-3 needs-validation" novalidate @submit.prevent="preregister">

                     <div class="col-12 mb-1">
                      <label>Usuario</label>
                      <div class="input-group has-validation">
                        <input type="email" v-model="form.username" class="form-control" :class="{ 'is-invalid': errors.username, 'is-valid': errors.username === null }" placeholder="Ingresa tu usuario" required/> 
                        <div class="invalid-feedback" v-if="errors.username">
                          {{ errors.username }}
                        </div>
                      </div>
                    </div>

                    <div class="col-12 mb-1">
                      <label>Correo</label>
                      <div class="input-group has-validation">
                        <input type="email" v-model="form.email" class="form-control" :class="{ 'is-invalid': errors.email, 'is-valid': errors.email === null }" placeholder="Ingresa tu correo" required/> 
                        <div class="invalid-feedback" v-if="errors.email">
                          {{ errors.email }}
                        </div>
                      </div>
                    </div>

                    <div class="col-12 mb-1">
                      <label>Confirmar correo</label>
                      <div class="input-group has-validation">
                        <input type="email" v-model="form.confirmEmail" class="form-control" :class="{ 'is-invalid': errors.confirmEmail, 'is-valid': errors.confirmEmail === null }" placeholder="Ingresa nuevamente tu correo" required/> 
                        <div class="invalid-feedback" v-if="errors.confirmEmail">
                          {{ errors.confirmEmail }}
                        </div>
                      </div>
                    </div>

                    <div class="col-12 mb-1">
                      <label>Número de télefono</label>
                      <div class="input-group has-validation">
                        <input type="number" v-model="form.cellphone" class="form-control" :class="{ 'is-invalid': errors.cellphone, 'is-valid': errors.cellphone === null }" placeholder="Ingresa tu número télefonico" required/> 
                        <div class="invalid-feedback" v-if="errors.cellphone">
                          {{ errors.cellphone }}
                        </div>
                      </div>
                    </div>


                     <div class=" col-12 mb-2">  
                      <label>Contraseña</label>
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

                     <div class=" col-12 mb-2">  
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

                    <div class="col-12 mb-2">
                      <label for="submit" class="form-label mb-2" >Captcha</label>
                      <input class="form-control" type="text" v-model="form.captcha" :class="{ 'is-invalid': errors.captcha, 'is-valid': errors.captcha === null }" placeholder="Ingresa el captcha" required>
                      <div class="invalid-feedback" v-if="errors.captcha">
                          {{ errors.captcha }}
                      </div>
                       <div class="align-center selectable mt-3" @click="generateCapcha" >
                          <i class="fa fa-refresh"></i>
                       </div>
                      <div class="img-fluid image"  v-html="inputCapcha" ></div>
                    </div>

                     <div class="text-center">
                      <button type="submit" class="mt-4 btn btn-lg bg-gradient-danger w-100">Registrarse</button>
                    </div>
                     
                  </form>
                </div>
                <div class="card-footer text-center pt-0 px-sm-4 px-1">
                  <p class="mb-4 mx-auto">
                    ¿Ya tienes una cuenta existente?
                    <router-link
                      :to="{ name: 'Signin Illustration' }"
                      class="font-weight-bold"
                      >Iniciar sesión
                    </router-link>
                  </p>
                </div>
              </div>
            </div>
            <div
              class="col-6 mt-3 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 end-0 text-center justify-content-center flex-column"
            >
              <div
                class="position-relative bg-gradient-danger h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center"
              >
                <img
                  src="@/assets/img/shapes/pattern-lines.svg"
                  alt="pattern-lines"
                  class="position-absolute opacity-4 start-0"
                />
                <div class="position-relative">
                  <img
                    class="max-width-500 w-100 position-relative z-index-2"
                    src="@/assets/img/illustrations/rocket-white.png"
                    alt="rocket"
                  />
                </div>
                <h4 class="mt-5 text-white font-weight-bolder">
                  Tu viaje comienza aquí
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
import Autoregister from '../../use-cases/autoregister'
import router from '../../../../router/index'
const body = document.getElementsByTagName("body")[0];

import { mapMutations } from "vuex";
export default {
  name: "Autoregister",
  components: {
    Navbar,
  },
  data(){
    return {
    form:{
      email:"",
      confirmEmail: "",
      cellphone: "",
      username: "",
      password: "",
      confirmPassword: "",
      captcha: "",
    },
    errors:{
      email:"",
      confirmEmail: "",
      cellphone: "",
      username: "",
      password: "",
      confirmPassword: "",
      captcha: "",
    
    },
    inputCapcha: "",
    showPassword: false,
    showConfirmPassword: false,
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
  mounted(){
    this.generateCapcha()
  },
  methods: {
    generateCapcha(){
        let uniquechar = "";
        const randomchar = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        for (let i = 1; i < 5; i++) {
            uniquechar += randomchar.charAt(
                Math.random() * randomchar.length)
        }
       this.inputCapcha  = uniquechar;
    },
    togglePasswordVisibility(){
      this.showPassword = !this.showPassword;
    },
    toggleConfirmPasswordVisibility(){
      this.showConfirmPassword = !this.showConfirmPassword;
    },
    preregister(){
      this.errors.username = Validations.validateUsername(this.form.username);
      this.errors.email = Validations.validateEmail(this.form.email);
      this.errors.confirmEmail = Validations.validateConfirmEmail(this.form.email, this.form.confirmEmail);
      this.errors.cellphone = Validations.validateCellphone(this.form.cellphone);
      this.errors.password = Validations.validatePassword(this.form.password);
      this.errors.confirmPassword = Validations.validateConfirmPassword(this.form.password, this.form.confirmPassword);
      this.errors.captcha = Validations.validateCapcha(this.inputCapcha, this.form.captcha);

      if(!this.errors.username && !this.errors.email && !this.errors.confirmEmail && !this.errors.cellphone 
         && !this.errors.password && !this.errors.confirmPassword && !this.errors.captcha ){
        let payload=  {
            username: this.form.username,
            profile: "",
            email: this.form.email,
            password: this.form.password,
            person:{
              cellphone: this.form.cellphone
            },
            roles:[
              {
                id: 3
              }
            ]
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
              const {message, error, data} = await Autoregister(payload)
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

    ...mapMutations(["toggleEveryDisplay", "toggleHideConfig"]),
  },
};
</script>
<style scoped>
  .image {
      padding: 20px !important;
      font-weight: 400 !important;
      user-select: none !important;
      text-decoration: line-through !important;
      font-style: italic !important;
      font-size: x-large !important;
      border: hsl(216, 76%, 67%) 2px solid !important;
  }
  .selectable{
    cursor: pointer;
  }

</style>
