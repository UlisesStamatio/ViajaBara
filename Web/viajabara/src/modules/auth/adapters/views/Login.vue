<template>
  <Loader :isLoading="isLoading"/>
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
  <main class="mt-5 main-content">
    <section>
      <div class="page-header min-vh-100">
        <div class="container">
          <div class="row">
            <div
              class="mx-auto col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0"
            >
              <div class="card card-plain">
                <div class="pb-0 card-header text-start">
                  <h4 class="font-weight-bolder">Iniciar sesión</h4>
                  <p class="mb-0">Ingresa tu usuario y contraseña para iniciar sesión.</p>
                </div>
                <div class="card-body">


                  <form class="row g-3 needs-validation" novalidate @submit.prevent="prelogin">
                    <div class="col-12 mb-2">
                      <label>Correo</label>
                      <div class="input-group has-validation">
                        <input type="email" v-model="form.email" class="form-control" :class="{ 'is-invalid': errors.email, 'is-valid': errors.email === null }" placeholder="Ingresa tu correo" required/> 
                        <div class="invalid-feedback" v-if="errors.email">
                          {{ errors.email }}
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
                      <button type="submit" class="mt-4 btn btn-lg bg-gradient-primary w-100">Iniciar sesión</button>
                    </div>
                  </form>

                </div>
                <div class="px-1 pt-0 text-center card-footer px-lg-2">
                  <p class="mx-auto text-sm ">
                    ¿Has olvidado tu contraseña? 
                    <router-link
                      :to="{ name: 'Recuperar Contraseña' }"
                      class=" font-weight-bold"
                    >Recuperar</router-link>
                  </p>

                  <p class="mx-auto mb-4 text-sm">
                    ¿No tienes una cuenta? 
                    <router-link
                      :to="{ name: 'Signup Illustration' }"
                      class=" font-weight-bold"
                    >
                      Registrarse
                    </router-link>
                  </p>
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
                    src="@/assets/img/illustrations/chat.png"
                    alt="chat-img"
                  />
                </div>
                <h4 class="mt-5 text-white font-weight-bolder">
                  La atención es la nueva moneda
                </h4>
                <p class="text-white">
                 Cuanto más sencilla parece la escritura, más esfuerzo pone el escritor en el proceso.
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
import Validations from "../../../../kernel/validators/login.validator"
import Login from '../../use-cases/login'
import router from '../../../../router/index'
import { mapMutations } from "vuex";
import Loader from '../../../../components/Loader.vue'
const body = document.getElementsByTagName("body")[0];

export default {
  name: "Login",
  components: {
    Navbar,
    Loader,
  },
  data(){
    return {
      inputCapcha: "",
      form:{
        email: "",
        password: "",
        captcha: ""
      },
      errors:{
        email: "",
        password: "",
        captcha: ""
      },
      isLoading: false,
      showPassword: false,
    }
  },
  mounted(){
    this.generateCapcha();
  },
  methods: {
    ...mapMutations(["toggleEveryDisplay", "toggleHideConfig"]),
    generateCapcha(){
        let uniquechar = "";
        const randomchar = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        for (let i = 1; i < 5; i++) {
            uniquechar += randomchar.charAt(
                Math.random() * randomchar.length)
        }
       this.inputCapcha  = uniquechar;
    },
    async prelogin () {
      let form  = { ...this.form} 
      
      this.errors.email = Validations.validateEmail(form.email)
      this.errors.captcha = Validations.validateCapcha(this.inputCapcha, form.captcha)
      this.errors.password = Validations.validatePassword(form.password)

      form = {
        email: form.email, 
        password: form.password
      }

      if(!this.errors.email && !this.errors.captcha && !this.errors.password){
          this.isLoading = true;
          const response = await Login(form)
          const {data, error} = response;
          this.isLoading = false;
          if(!error){
            const {roles} = data;
            if(roles.some((rol) => rol.keyRole === 'ADMIN')){
              router.push({name: 'Consultar Usuarios'})
            }else{
              this.$swal({
                icon: "warning", 
                title: "¡No eres administrador, no estas autorizado!",
                type: "basic",
              });
            }
          }else{
            const {text} = data
            this.$swal({
                icon: "error", 
                title: text,
                type: "basic",
              });
          }
      }


      //router.push({ name: 'Modificar Viaje' });
    },
     togglePasswordVisibility() {
      this.showPassword = !this.showPassword;
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
