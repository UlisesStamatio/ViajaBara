<template>
  <div class="container-fluid">
    <div class="row">
      <div class="mx-auto col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row mx-5">
            <div class="col-12">
              <label>Punto de inicio(<span class="text-danger">*</span>)</label>
                <div class="input-group flex-nowrap">
                  <input
                  type="text"
                  class="form-control" 
                  placeholder="Ingresa la dirección" 
                  id="password-input"  
                  />
                  <span class="input-group-text" id="password-input" @click="openModal()" style="cursor:pointer;">
                    <i class="fa fa-map-marker"></i>
                  </span>
              </div>
            </div>
            <div class="col-12">
              <label>Destino(<span class="text-danger">*</span>)</label>
               <div class="input-group flex-nowrap">
                  <input
                  type="text"
                  class="form-control" 
                  placeholder="Ingresa la dirección" 
                  id="password-input"  
                  />
                  <span class="input-group-text" id="password-input" @click="openModal()" style="cursor:pointer;">
                    <i class="fa fa-map-marker"></i>
                  </span>
              </div>
            </div>
             <div class="col-12">
              <label>Servicio(<span class="text-danger">*</span>)</label>
              <select
                id="choices-category"
                class="form-control"
                name="choices-category"
              >
                <option value="Choice 1" >Solo ida</option>
                <option value="Choice 2">Ida y vuelta</option>
                <option selected="">Selecciona una opción...</option>
              </select>
            </div>

          

        </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">
              <soft-button
                type="button"
                color="secondary"
                variant="gradient"
                class="mb-0 me-2 ms-auto js-btn-next"
                title="Next"
                @click="this.$parent.nextStep"
                >Cancelar</soft-button>
              <soft-button
                type="button"
                color="dark"
                variant="gradient"
                class="mb-0 ms-auto js-btn-next"
                title="Next"
                @click="this.$parent.nextStep"
                >Crear ruta</soft-button>
            </div>
          </div>
      </div>
    </div>
  </div>
  </div>

    <MDBModal
      id="exampleModal"
      tabindex="-1"
      labelledby="exampleModalLabel"
      v-model="exampleModal"
    >
      <MDBModalHeader>
        <MDBModalTitle id="exampleModalLabel">Ubicación </MDBModalTitle>
      </MDBModalHeader>
      <MDBModalBody>
              <div class="container-d">
                <div class="row">
                  <div class="col-12 mb-3">
                    <label>Dirección</label>
                      <div class="input-group flex-nowrap">
                        <input
                        type="text"
                        class="form-control" 
                        placeholder="Ingresa la dirección" 
                        id="address-input"  
                        v-model="searchQuery"
                        @input="updateSearch()"
                        />
                        <span class="input-group-text" id="password-input" style="cursor:pointer;">
                          <i class="fas fa-search"></i>
                        </span>
                    </div>
                    <ul>
                      <li v-for="place in placesSearched" :key="place.id" @click="selectPlace(place)">{{ place.description }}</li>
                    </ul>
                  
                  </div>
                   <hr class="horizontal dark" />
                  <div class="col-12">
                    <GMapMap
                      :center="center"
                      ref="myMapRef"
                      :zoom="zoom"
                      @click="onMapClick"
                      style="height: 20rem"
                      :options="mapOptions"
                    >
                      <GMapMarker
                        v-if="marker"
                        :position="marker.position"
                      />
                    </GMapMap>
                  </div>
                </div>
              </div>

      </MDBModalBody>
      <MDBModalFooter >
        <div class="container-fluid">
          <div class="row">
            <div class="col-12 text-center">
              <button  class="btn bg-gradient-secondary me-2" @click="exampleModal = false">Cancelar</button>
              <button  class="btn bg-gradient-dark">Seleccionar</button>
            </div>
          </div>
        </div>
      </MDBModalFooter>
    </MDBModal>

</template>

<script>
import Quill from "quill";
import Choices from "choices.js";
import SoftButton from "@/components/SoftButton.vue";
import mapFunctions from '../../../../kernel/map-functions/maps'


 import {
    MDBModal,
    MDBModalBody,
    MDBModalHeader,
    MDBModalTitle,
    MDBModalFooter
  } from 'mdb-vue-ui-kit';

export default {
  name: "NewRoute",
  components: {
    SoftButton,
    MDBModal,
    MDBModalBody,
    MDBModalHeader,
    MDBModalTitle,
    MDBModalFooter,
  },
  data() {
    return {
      showMenu: false,
      activeClass: "js-active position-relative",
      activeStep: 0,
      formSteps: 3,
      center:{},
      zoom: 12,
      marker: null,
      exampleModal:false,
      mapOptions: {
        disableDefaultUI: true, // Esto desactivará la interfaz de usuario predeterminada (opciones, hombre naranja, etc.)
      },
      searchQuery:"",
      placesSearched: [],
      geocoder: {}
    };
  },
  mounted() {
    if (document.getElementById("edit-description")) {
      // eslint-disable-next-line no-unused-vars
      var quill = new Quill("#edit-description", {
        theme: "snow", // Specify theme in configuration
      });
    }
    if (document.getElementById("choices-category")) {
      var element = document.getElementById("choices-category");
      new Choices(element, {
        searchEnabled: false,
      });
    }
    if (document.getElementById("choices-sizes")) {
      let element = document.getElementById("choices-sizes");
      new Choices(element, {
        searchEnabled: false,
      });
    }
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
      async onMapClick(event) {
      console.log(event);
      const latLng = event.latLng;  
      console.log(latLng);
      mapFunctions.getAddressByLatLng(latLng).then((response) =>{
          this.searchQuery = response
      }).catch((err)=>{
        this.$swal({
          icon: "error", 
          title: err,
          type: "basic",
        });
      })

      this.marker = { position: { lat: latLng.lat(), lng: latLng.lng()} };
    },
     openModal(){
      mapFunctions.getCurrentPosition().then(async (response) =>{
        console.log(response);
        this.center = {lat: response.coords.latitude, lng: response.coords.longitude}
        let position = await mapFunctions.convertLatLng(this.center.lat, this.center.lng);
        let adress = await mapFunctions.getAddressByLatLng(position);
        console.log(adress);
        this.exampleModal = true
        this.marker = {position: {...this.center}}
      }).catch((err)=>{
        this.$swal({
          icon: "error", 
          title: err,
          type: "basic",
        });
      })
     
    },
    async updateSearch() {
       const {AutocompleteService} = await window.google.maps.importLibrary("places")
       const instance = new AutocompleteService();
       if(this.searchQuery || this.searchQuery !== ''){
            instance.getQueryPredictions({ input: this.searchQuery }, (predictions) =>{
              this.placesSearched = predictions;
            })
       }else{
        this.placesSearched = [];
       }
    },
    async selectPlace(place){
      const {place_id, description} = place
      this.searchQuery = description;
      this.placesSearched = [];
      const geocoder = new window.google.maps.Geocoder();
      geocoder.geocode({ placeId: place_id }, (results, status) => {
        if (status === "OK") {
          if (results[0]) {
            // Obtiene la dirección desde los resultados
            let address =  results[0].geometry.location;
            this.center = { lat: address.lat() , lng: address.lng()}
            this.marker = { position: { lat: address.lat(), lng: address.lng()} };
            
          } else {
            console.error("No se encontraron resultados de geocodificación.");
          }
        } else {
          console.error("Error en la solicitud de geocodificación: ", status);
        }
      });
      
    }
  },
  emits: ['position_changed'],
};
</script>
