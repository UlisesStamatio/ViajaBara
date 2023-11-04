<template>
  <div class="py-4 container-fluid">
    <form class="mt-4 row" @submit.prevent="preNewBus()">
      <div class="col-lg-4">
        <div class="card h-100">
          <div class="card-body">
            <div class="row">
              <div class="col-12 text-center">
                <label>Imagen del autobus(<span class="text-danger">*</span>)</label>
                <img
                  id="image-bus"
                  class="mt-3 shadow-lg w-100 border-radius-lg"
                  alt="autobus_image"
                />
              </div>
              <div class="col-12 mt-2 text-center">
                 <input type="file" id="img-input" class="d-none" @change="handleFileChange" accept=".png, .jpg, .jpeg" > 
                 <div :class="{'invalid-feedback':errors.profile}" style="color: red;">
                  {{ errors.image}}
                </div>
              </div>
              <div class="mt-4 col-12  text-center">
                  <button
                    class="mb-0 btn bg-gradient-primary btn-sm me-2"
                    type="button"
                    name="button"
                    title="Editar imagen"
                    @click="openExplorer"
                  >
                    Editar
                  </button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="mt-4 col-lg-8 mt-lg-0">
        <div class="card">
          <div class="card-body">
            <h5 class="font-weight-bolder">Información del autobus</h5>
            <div class="row mt-3">
              <div class="col-12 col-sm-6 mb-3">
                <label>Placa(<span class="text-danger">*</span>)</label>
                <input
                    id="plaque"
                    type="text"
                    placeholder="e.g. PUJ23J"
                    name="plaque"
                    class="form-control"
                    v-model.trim="bus.plaque"
                    :class="{ 'is-invalid': errors.plaque, 'is-valid': errors.plaque === null }"
                />
              <div class="invalid-feedback" v-if="errors.plaque">
                  {{ errors.plaque }}
              </div>
              </div>
              <div class="mt-3 col-12 col-sm-6 mb-3 mt-sm-0">
               <label>Marca(<span class="text-danger">*</span>)</label>
                <input
                    id="mark"
                    type="text"
                    placeholder="e.g. Vogager"
                    name="mark"
                    class="form-control"
                    v-model.trim="bus.mark"
                    :class="{ 'is-invalid': errors.mark, 'is-valid': errors.mark === null }"
                />
              <div class="invalid-feedback" v-if="errors.mark">
                  {{ errors.mark }}
              </div>
              </div>
            </div>
            <div class="row">
              <div class="col-12 col-sm-6 mb-3">
                <label>Modelo(<span class="text-danger">*</span>)</label>
                <input
                    id="model"
                    type="text"
                    placeholder="e.g. Vogager 2023"
                    name="model"
                    class="form-control"
                    v-model.trim="bus.model"
                    :class="{ 'is-invalid': errors.model, 'is-valid': errors.model === null }"
                />
              <div class="invalid-feedback" v-if="errors.model">
                  {{ errors.model }}
              </div>
              </div>
              <div class="mt-3 col-12 col-sm-6 mb-3 mt-sm-0">
               <label>Número de serie(<span class="text-danger">*</span>)</label>
                <input
                    id="serial"
                    type="text"
                    placeholder="eg. HSG-SH1"
                    name="serial"
                    class="form-control"
                    v-model.trim="bus.serial"
                    :class="{ 'is-invalid': errors.serial, 'is-valid': errors.serial === null }"
                />
              <div class="invalid-feedback" v-if="errors.serial">
                  {{ errors.serial }}
              </div>
              </div>
            </div>
            <div class="row">
              <div class="mt-3 col-12 col-sm-6 mb-3 mt-sm-0">
               <label>Combustible(<span class="text-danger">*</span>)</label>
                <input
                    id="name"
                    type="text"
                    placeholder="eg. Diesel"
                    name="name"
                    class="form-control"
                    v-model.trim="bus.fuel"
                    :class="{ 'is-invalid': errors.fuel, 'is-valid': errors.fuel === null }"
                />
              <div class="invalid-feedback" v-if="errors.fuel">
                  {{ errors.fuel }}
              </div>
              </div>
            </div>


            <div class="row mt-5">
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
                title="Crear autobus"
                >
                  Crear autobus
                </button>
                </div>
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
import Choices from "choices.js";
import imagesEmpty from '../../../../assets/img/errorImagen.png'
import busValidator from '../../../../kernel/validators/bus.validator'
import newBus from '../../use-cases/new.bus'
import router from '../../../../router/index'

export default {
  name: "NewBus",
   components: {
  },
  data(){
     return{
      bus:{
        plaque: "",
        image: "",
        mark: "",
        model: "",
        serial: "",
        fuel: ""
      },
      errors:{
        plaque: "",
        image: "",
        mark: "",
        model: "",
        serial: "",
        fuel: ""
      },
      image: "",
     }
  },
  mounted() {
    this.setImage()
    if (document.getElementById("edit-description-edit")) {
      new Quill("#edit-description-edit", {
        theme: "snow", // Specify theme in configuration
      });
    }
    this.getChoices("choices-category-edit");
    this.getChoices("choices-color-edit");
    this.getChoices("choices-currency-edit");

    if (document.getElementById("choices-tags-edit")) {
      var tags = document.getElementById("choices-tags-edit");
      const examples = new Choices(tags, {
        removeItemButton: true,
      });

      examples.setChoices(
        [
          {
            value: "One",
            label: "Expired",
            disabled: true,
          },
          {
            value: "Two",
            label: "Out of Stock",
            selected: true,
          },
        ],
        "value",
        "label",
        false
      );
    }
    
  },
  methods: {
    setImage(){
        document.getElementById("image-bus").src = imagesEmpty
    },
    getChoices(id) {
      if (document.getElementById(id)) {
        var element = document.getElementById(id);
        return new Choices(element, {
          searchEnabled: false,
        });
      }
    },
    goBackPage(){
      this.user = {}
      this.errors = {}
       router.push({name: 'Consultar Autobuses'})
    },
     async handleFileChange(e){
      this.errors.image = null
      const input = document.getElementById("img-input")
      const file = e.target.files[0];
      const isFile = busValidator.validateImage(file);
      if(isFile){
        this.setImage()
        this.bus.image = null;
        this.errors.image = isFile;
        input.value = null;
      }else{
        this.bus.image = file
        document.getElementById("image-bus").src = await blobToBase64(file) 
      }
      setTimeout(() => {
        this.errors.image = null;
      }, 3000);
      
     
    },
     openExplorer(){
      const input = document.getElementById("img-input")
      input.click()
    },
    async preNewBus(){
      let bus  = {...this.bus}
      this.errors.plaque = busValidator.validatePlaque(bus.plaque);
      this.errors.mark = busValidator.validateMark(bus.mark);
      this.errors.model = busValidator.validateModel(bus.model);
      this.errors.serial = busValidator.validateSerial(bus.serial);
      this.errors.fuel = busValidator.validatePlaque(bus.fuel);
      this.errors.image = busValidator.validateImage(bus.image);

      if(!this.errors.plaque && !this.errors.mark && !this.errors.model &&
          !this.errors.serial && !this.errors.fuel && !this.errors.image){
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
              bus.image = document.getElementById('image-bus').src.split('base64,')[1]
              const {message, error, data} = await newBus(bus)
              if(!error){
                const {result:{text}} = data
                this.$swal({
                  icon: "success",
                  title: message,
                  text: text,
                  type: 'success-message',
                });
                router.push({name: 'Consultar Autobuses'})
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
    }
  },
};
</script>
