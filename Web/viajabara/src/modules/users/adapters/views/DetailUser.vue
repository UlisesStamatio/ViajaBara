<template>
<Loader :isLoading="isLoading"/>
  <div class="container-fluid">
    <div class="row g-3" >
      <div class="col-12 col-md-4">
        <div class="mt-4 card card-body">
                    <div class="row text-center">
            <div class="col">
              <label>Imagen de perfil</label>
            </div>
           <div class="col-12 mb-3">
                <img
                  class="mt-3 shadow-lg img-fluid border-radius-lg w-80 h-100"
                  id="image_profile"
                  alt="autobus_image"
                />

              </div>
          </div>   
        </div>
      </div>
      <div class="mx-auto col-md-8 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row">
            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Nombre:</label>
              <input
                id="name"
                type="text"
                v-model.trim="user.name"
                placeholder="eg. Michael"
                name="name"
                class="form-control"
                disabled
              />
            </div>
            <div class="col-12 col-sm-6 col-lg-4  mb-3">
              <label>Apellido Paterno:</label>
              <input
                id="lastname"
                type="text"
                placeholder="eg. Jackson"
                name="lastname"
                v-model.trim="user.lastname"
                class="form-control"
                disabled
              />
            </div>
            <div class="col-12 col-sm-6 col-lg-4  mb-3">
              <label>Apellido Materno:</label>
              <input
                id="surname"
                type="text"
                placeholder="eg. Smith"
                name="surname"
                v-model.trim="user.surname"
                class="form-control"
                disabled
              />
            </div>

            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Sexo:</label>
              <select
                id="sex-select"
                class="form-control"
                name="sex-select"
                v-model.trim="user.sex"
                disabled
              >
                <option value="" selected disabled>Selecciona una opción...</option>
                <option value="1" >Masculino</option>
                <option value="2">Femenino</option>
              </select>
            </div>

            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Fecha de nacimiento:</label>
             <input
                id="birthday"
                type="date"
                name="birthday"
                v-model.trim="user.birthday"
                class="form-control"
                disabled
              />
            </div>

            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Estado de residencia:</label>
              <select
                id="state-select"
                class="form-control"
                name="state-select"
                v-model.trim="user.state"
                disabled
              >
                <option value="" selected disabled>Selecciona una opción...</option>
                <option v-for="({id, name}, index) in states" :key="index" :value="id" >{{name}}</option>
              </select>
            </div>

              <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Télefono:</label>
             <input
                id="cellphone"
                type="number"
                placeholder="eg. 76568788787"
                name="cellphone"
                v-model.trim="user.cellphone"
                class="form-control"
                disabled
              />
            </div>

              <div class="col-12 col-sm-6 col-lg-4 mb-3">
                <label>Usuario:</label>
                <input
                  id="username"
                  type="text"
                  placeholder="eg. MichaelJack"
                  name="username"
                  v-model.trim="user.username"
                  class="form-control"
                  disabled
                />
              </div>

              <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Correo:</label>
              <input
                id="email"
                type="email"
                placeholder="eg. example@address.com"
                name="email"
                v-model.trim="user.email"
                class="form-control"
                disabled
              />
            </div>

            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Confirmar correo:</label>
              <input
                id="confirmEmail"
                type="email"
                placeholder="eg. example@address.com"
                name="confirmEmail"
                v-model.trim="user.confirmEmail"
                class="form-control"
                disabled
              />
            </div>


          </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">

                <button 
                type="button"
                class="mb-0 me-2 ms-auto btn js-btn-next bg-gradient-dark"
                title="Crear usuario"
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
import router from '../../../../router/index'
import listStates from '../../../state/use-cases/list.state'
import getUser from '../../use-cases/get.user'
import Loader from '../../../../components/Loader.vue'

export default {
  name: "DetailUser",
  components:{
    Loader,
  },
  data() {
    return {
      showMenu: false,
      activeClass: "js-active position-relative",
      activeStep: 0,
      formSteps: 3,
      preview: "",
      states: [],
      user:{
        profile: "",
        name: "",
        lastname: "",
        surname: "",
        sex: "",
        birthday: "",
        cellphone: "",
        username: "",
        email: "",
        confirmEmail: "",
        state: "",

      },
      idUser: 0,
      isLoading: false,
    };
  },
  async mounted() {
     this.idUser = this.$route.params.id;
    await this.getUser( this.idUser);
    if (document.getElementById("edit-description")) {
      // eslint-disable-next-line no-unused-vars
      var quill = new Quill("#edit-description", {
        theme: "snow", // Specify theme in configuration
      });
    }
    await this.listStates();
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
    async listStates(){
      const response = {...await listStates()};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.states = result
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async getUser(id){
      this.isLoading = true;
      const response = {...await getUser(id)};
      const {error, data} = response;
      this.isLoading = false;
        if(!error){
          const {result:{profile}} = data
          const {result} = data
          document.getElementById("image_profile").src = `data:image/png;base64,${profile}`;
          this.user = result;
          this.userOriginal = {...result}
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    goBackPage(){
      this.user = {}
      this.errors = {}
       router.push({name: 'Consultar Usuarios'})
    },


      
  },
};
</script>
