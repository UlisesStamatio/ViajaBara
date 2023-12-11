<template>
  <Loader :isLoading="isLoading"/>
  <div class="py-4 container-fluid">
    <form class="mt-4 row">
      <div class="col-lg-4">
        <div class="card ">
          <div class="card-body">
            <div class="row">
              <div class="col-12 text-center">
                 <label>Imagen de la unidad:</label>
                <img
                  id="image-bus"
                  class="mt-3 shadow-lg w-100 border-radius-lg"
                  alt="autobus_image"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="mt-4 col-lg-8 mt-lg-0">
        <div class="card">
          <div class="card-body">
            <h5 class="font-weight-bolder">Información de la unidad</h5>
            <div class="row mt-3">
              <div class="col-12 col-sm-6 mb-4">
                 <label>Placa:</label>
                <input
                    id="plaque"
                    type="text"
                    placeholder="e.g. PUJ23J"
                    name="plaque"
                    class="form-control"
                    disabled
                    :value="bus.plaque"
                />
              </div>
              <div class="mt-3 col-12 col-sm-6 mb-4 mt-sm-0">
                <label>Marca:</label>
                <input
                    id="mark"
                    type="text"
                    placeholder="e.g. Vogager"
                    name="mark"
                    class="form-control"
                    disabled
                    :value="bus.mark"
                />
              </div>
            </div>
            <div class="row">
              <div class="col-12 col-sm-6 mb-4">
                <label>Modelo:</label>
                <input
                    id="model"
                    type="text"
                    placeholder="e.g. Vogager 2023"
                    name="model"
                    class="form-control"
                    disabled
                    :value="bus.model"
                />
              </div>
             
             <div class="col-12 col-sm-6  mb-3">
              <label>Tipo de Unidad(<span class="text-danger">*</span>)</label>
              <select
                id="sex-select"
                class="form-control"
                name="sex-select"
                :value="bus.typeBus.id"
                disabled
              >
                <option value="" selected disabled>Selecciona una opción...</option>
                <option v-for="(type, index) in types" :key="index" :value="type.id" >{{type.description}}</option>
              </select>
            </div>
              
            </div>
            <div class="row">
              <div class="mt-3 col-12 col-sm-6 mb-4 mt-sm-0">
                <label>Número de serie:</label>
                <input
                    id="serial"
                    type="text"
                    placeholder="eg. HSG-SH1"
                    name="serial"
                    class="form-control"
                    disabled
                    :value="bus.serial"
                />
              </div>
              <div class="mt-3 col-12 col-sm-6 mb-4 mt-sm-0">
                <label>Combustible:</label>
                <input
                    id="name"
                    type="text"
                    placeholder="eg. Diesel"
                    name="name"
                    class="form-control"
                    disabled
                    :value="bus.fuel"
                />
              </div>
            </div>


            <div class="row mt-5">
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
    </form>
  </div>
</template>

<script>
import Choices from "choices.js";
import getBus from '../../use-cases/get.bus'
import router from '../../../../router/index'
import Loader from '../../../../components/Loader.vue'
import listTypeBusEnabled from '../../use-cases/list.type.bus.enabled'

export default {
  name: "DetailBus",
   components: {
    Loader,
  },
  data(){
     return{
      bus:{
        plaque: "",
        image: "",
        mark: "",
        model: "",
        serial: "",
        fuel: "",
        typeBus:{
          id: ""
        }
      },
      idBus: 0,
      isLoading: false,
      types: [],
     }
  },
    async mounted() {
    this.idBus = this.$route.params.id;
    this.isLoading = true;
    await this.getBus( this.idBus);
    await this.listTypeBusEnabled()
    this.isLoading = false;
  },
  methods: {
    async listTypeBusEnabled(){
      const response = {...await listTypeBusEnabled()};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.types = result
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async getBus(id){
      const response = {...await getBus(id)};
      const {error, data} = response;
        if(!error){
          const {result} = data
          document.getElementById("image-bus").src = `data:image/png;base64,${result.image}`;
          this.bus = result;
          this.busOriginal = {...result}
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
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
       router.push({name: 'Consultar Unidades'})
    },
    
  },
};
</script>
