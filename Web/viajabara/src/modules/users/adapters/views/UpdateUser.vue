<template>
  <div class="container-fluid">


    <form class="row g-3" @submit.prevent="preNewUser">
      <div class="col-12 col-sm-4">
        <div class="mt-4 card card-body">
                    <div class="row text-center">
            <div class="col">
              <label>Imagen de perfil(<span class="text-danger">*</span>)</label>
            </div>
           <div class="col-12">
                <img
                  class="mt-3 shadow-lg img-fluid border-radius-lg w-100 h-auto"
                  id="image_profile"
                  alt="autobus_image"
                />
                
                <input type="file" id="img-input" class="d-none" :class="{ 'is-invalid': errors.profile, 'is-valid': errors.profile === null }" @change="handleFileChange" accept=".png, .jpg, .jpeg" > 
                <div class="invalid-feedback" v-if="errors.profile">
                          {{ errors.profile }}
                </div>
              </div>
              <div class="mt-4 col-12">
                  <button
                    class="mb-0 btn bg-gradient-primary btn-sm me-2"
                    type="button"
                    name="button"
                    @click="openExplorer"
                  >
                    Editar
                  </button>
              </div>
          </div>   
        </div>
      </div>
      <div class="mx-auto col-sm-8 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row">
            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Nombre(<span class="text-danger">*</span>)</label>
              <input
                id="name"
                type="text"
                v-model.trim="user.name"
                placeholder="eg. Michael"
                name="name"
                class="form-control"
                :class="{ 'is-invalid': errors.name, 'is-valid': errors.name === null }"
              />
              <div class="invalid-feedback" v-if="errors.name">
                  {{ errors.name }}
              </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-4  mb-3">
              <label>Apellido Paterno(<span class="text-danger">*</span>)</label>
              <input
                id="lastname"
                type="text"
                placeholder="eg. Jackson"
                name="lastname"
                v-model.trim="user.lastname"
                class="form-control"
               :class="{ 'is-invalid': errors.lastname, 'is-valid': errors.lastname === null }"
              />
              <div class="invalid-feedback" v-if="errors.lastname">
                  {{ errors.lastname }}
              </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-4  mb-3">
              <label>Apellido Materno</label>
              <input
                id="surname"
                type="text"
                placeholder="eg. Smith"
                name="surname"
                v-model.trim="user.surname"
                class="form-control"
              :class="{ 'is-invalid': errors.surname, 'is-valid': errors.surname === null }"
              />
              <div class="invalid-feedback" v-if="errors.surname">
                  {{ errors.surname }}
              </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Sexo(<span class="text-danger">*</span>)</label>
              <select
                id="sex-select"
                class="form-control"
                name="sex-select"
                v-model.trim="user.sex"
                :class="{ 'is-invalid': errors.sex, 'is-valid': errors.sex === null }"
              >
                <option value="" selected disabled>Selecciona una opción...</option>
                <option value="1" >Masculino</option>
                <option value="2">Femenino</option>
              </select>
              <div class="invalid-feedback" v-if="errors.sex">
                  {{ errors.sex }}
              </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Fecha de nacimiento(<span class="text-danger">*</span>)</label>
             <input
                id="birthday"
                type="date"
                name="birthday"
                v-model.trim="user.birthday"
                class="form-control"
              :class="{ 'is-invalid': errors.birthday, 'is-valid': errors.birthday === null }"
              />
              <div class="invalid-feedback" v-if="errors.birthday">
                  {{ errors.birthday }}
              </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Estado de residencia(<span class="text-danger">*</span>)</label>
              <select
                id="state-select"
                class="form-control"
                name="state-select"
                v-model.trim="user.state"
                :class="{ 'is-invalid': errors.state, 'is-valid': errors.state === null }"
              >
                <option value="" selected disabled>Selecciona una opción...</option>
                <option v-for="({id, name}, index) in states" :key="index" :value="id" >{{name}}</option>
              </select>
              <div class="invalid-feedback" v-if="errors.state">
                  {{ errors.state }}
              </div>
            </div>

              <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Télefono(<span class="text-danger">*</span>)</label>
             <input
                id="cellphone"
                type="number"
                placeholder="eg. 76568788787"
                name="cellphone"
                v-model.trim="user.cellphone"
                class="form-control"
               :class="{ 'is-invalid': errors.cellphone, 'is-valid': errors.cellphone === null }"
              />
              <div class="invalid-feedback" v-if="errors.cellphone">
                  {{ errors.cellphone }}
              </div>
            </div>

              <div class="col-12 col-sm-6 col-lg-4 mb-3">
                <label>Usuario(<span class="text-danger">*</span>)</label>
                <input
                  id="username"
                  type="text"
                  placeholder="eg. MichaelJack"
                  name="username"
                  v-model.trim="user.username"
                  class="form-control"
                :class="{ 'is-invalid': errors.username, 'is-valid': errors.username === null }"
                />
                <div class="invalid-feedback" v-if="errors.username">
                    {{ errors.username }}
                </div>
              </div>

              <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Correo(<span class="text-danger">*</span>)</label>
              <input
                id="email"
                type="email"
                placeholder="eg. example@address.com"
                name="email"
                v-model.trim="user.email"
                class="form-control"
               :class="{ 'is-invalid': errors.email, 'is-valid': errors.email === null }"
              />
              <div class="invalid-feedback" v-if="errors.email">
                  {{ errors.email }}
              </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-4 mb-3">
              <label>Confirmar correo(<span class="text-danger">*</span>)</label>
              <input
                id="confirmEmail"
                type="email"
                placeholder="eg. example@address.com"
                name="confirmEmail"
                v-model.trim="user.confirmEmail"
                class="form-control"
               :class="{ 'is-invalid': errors.confirmEmail, 'is-valid': errors.confirmEmail === null }"
              />
              <div class="invalid-feedback" v-if="errors.confirmEmail">
                  {{ errors.confirmEmail }}
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
                title="Crear usuario"
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
import blobToBase64 from '../../../../kernel/translate/blobToBase64'
import userValidator from '../../../../kernel/validators/user.validator'
import router from '../../../../router/index'
import listStates from '../../../state/use-cases/list.state'
import getUser from '../../use-cases/get.user'
import updateUser from '../../use-cases/update.user'

export default {
  name: "NewUser",
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
      errors:{
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
      userOriginal: {},
    };
  },
  computed:{
    isFormModified(){
        for (const key in this.user) {
          if (this.user[key] !== this.userOriginal[key]) {
              return true;
          }
        }
        return false;
    }
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
      const response = {...await getUser(id)};
      const {error, data} = response;
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
    openExplorer(){
      const input = document.getElementById("img-input")
      input.click()
    },
    async handleFileChange(e){
      const input = document.getElementById("img-input")
      const file = e.target.files[0];
      const isFile = userValidator.validateImage(file);
      if(isFile){
        this.errors.profile = isFile;
        input.value = null;
      }else{
        document.getElementById("image_profile").src = await blobToBase64(file) 
        this.user.profile = document.getElementById('image_profile').src.split('base64,')[1]
      }
      setTimeout(() => {
        this.errors.profile = null;
      }, 3000);
      
     
    },
    goBackPage(){
      this.user = {}
      this.errors = {}
       router.push({name: 'Consultar Usuarios'})
    },
    async preNewUser(){
      let user  = { ...this.user} 
      this.errors.name = userValidator.validateName(user.name);
      this.errors.lastname = userValidator.validateLastname(user.lastname);
      this.errors.surname = userValidator.validateSurname(user.surname);
      this.errors.sex = userValidator.validateSex(user.sex);
      this.errors.birthday = userValidator.validateBirthday(user.birthday);
      this.errors.state = userValidator.validateState(user.state, this.states);
      this.errors.cellphone = userValidator.validateCellphone(user.cellphone);
      this.errors.username = userValidator.validateUsername(user.username);
      this.errors.email = userValidator.validateEmail(user.email);
      this.errors.confirmEmail = userValidator.validateConfirmEmail(user.email, user.confirmEmail);

      if(this.isFormModified){
        if(!this.errors.name && !this.errors.lastname && ! this.errors.surname &&
          !this.errors.sex && !this.errors.birthday && !this.errors.cellphone &&
          !this.errors.username && !this.errors.email  && ! this.errors.confirmEmail && !this.errors.state){
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
                user.id =  this.idUser
                user.profile = document.getElementById('image_profile').src.split('base64,')[1]
                const response = await updateUser(user)
                const {message, error, data}  = response
                if(!error){
                  const {result:{text}} = data
                  this.$swal({
                    icon: "success",
                    title: message,
                    text: text,
                    type: 'success-message',
                  });
                  router.push({name: 'Consultar Usuarios'})
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
