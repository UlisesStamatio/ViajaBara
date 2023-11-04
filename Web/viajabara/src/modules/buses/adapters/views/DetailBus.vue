<template>
  <div class="py-4 container-fluid">
    <form class="mt-4 row">
      <div class="col-lg-4">
        <div class="card h-100">
          <div class="card-body">
            <div class="row">
              <div class="col-12 text-center">
                 <label>Imagen del autobus:</label>
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
            <h5 class="font-weight-bolder">Información del autobus</h5>
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
                    v-model.trim="bus.plaque"
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
                    v-model.trim="bus.mark"
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
                    v-model.trim="bus.model"
                />
              </div>
              <div class="mt-3 col-12 col-sm-6 mb-4 mt-sm-0">
                <label>Número de serie:</label>
                <input
                    id="serial"
                    type="text"
                    placeholder="eg. HSG-SH1"
                    name="serial"
                    class="form-control"
                    disabled
                    v-model.trim="bus.serial"
                />
              </div>
            </div>
            <div class="row">
              <div class="mt-3 col-12 col-sm-6 mb-4 mt-sm-0">
                <label>Combustible:</label>
                <input
                    id="name"
                    type="text"
                    placeholder="eg. Diesel"
                    name="name"
                    class="form-control"
                    disabled
                    v-model.trim="bus.fuel"
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
import Quill from "quill";
import Choices from "choices.js";
import getBus from '../../use-cases/get.bus'
import router from '../../../../router/index'

export default {
  name: "DetailBus",
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
      idBus: 0,
     }
  },
    async mounted() {
    this.idBus = this.$route.params.id;
    await this.getBus( this.idBus);

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
       router.push({name: 'Consultar Autobuses'})
    },
    
  },
};
</script>
