<template>
<Loader :isLoading="isLoading"/>
  <div class="container-fluid" v-show="!isLoading">
    <div class="row">
      <div class=" col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row mx-2">
            <div class="col-12">
              <label>Nombre de la ruta(<span class="text-danger">*</span>)</label>
                  <input
                  type="text"
                  class="form-control" 
                  placeholder="Ingresa el nombre" 
                  id="name-input" 
                  v-model="route.name" 
                  :class="{ 'is-invalid': errors.name, 'is-valid': errors.name === null }"
                  />
                  <div  v-if="errors.name" style="color: red">
                      {{ errors.name }}
                 </div>
            </div>
            <hr class="my-4 horizontal dark" />
            <div class="col-12 mb-2">
                <div class="d-lg-flex">
                  <div>
                    <h5 class="mb-0">Paradas</h5>
                  </div>
                  <div class="my-auto mt-4 ms-auto mt-lg-0">
                    <div class="my-auto ms-auto">
                      <button class="mb-0 btn bg-gradient-danger btn-sm" @click="openModalStopover()">+&nbsp; Nueva Parada</button>
                    </div>
                  </div>
                </div>
            </div>
            <div class="col-12 table-responsive mt-3">
              <table class="table table-flush" id="tableStopOvers" >
                <thead class="thead-light">
                    <tr>
                      <th style="font-size: 0.65em; font-weight: bold; text-align: start">#</th>
                      <th style="font-size: 0.65em; font-weight: bold">Dirección</th>
                      <th style="font-size: 0.65em; font-weight: bold">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablebody">
                  <tr  v-for="({description,lat, lng, latLng, sequence}, index) in route.stopOvers" :key="index">
                    <td v-text="index + 1 "></td>
                    <td>{{description}}</td>
                    <td>
                      <a
                        class="me-2"
                        @click="updateStopover({description,lat, lng,latLng, sequence})"
                        >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                        </a>

                        <a
                        @click="deleteStopover(sequence)"
                        >
                        <i class="fa fa-times-circle text-secondary" ></i>
                        </a>
                    </td>
                  </tr>
                </tbody>
              </table>
              <div  v-if="errors.stopovers" style="color: red">
                      {{ errors.stopovers }}
              </div>
            </div>

            <div class="col-12 mt-3 text-end ">
              <button
                class="btn bg-gradient-secondary me-2"
                title="Cancelar"
                @click="cancelar()"
                >Cancelar</button>
              <button
                class="btn bg-gradient-dark"
                title="Crear ruta"
                @click="preNewRoute()"
              >Crear ruta</button>
            </div>

        </div>

      </div>
    </div>
  </div>
  </div>



  <MDBModal
    id="newRouteEndPositionModal"
    tabindex="-1"
    labelledby="newRouteEndPositionModalLabel"
    v-model="exampleModalStopover"
  >
    <MDBModalHeader>
      <MDBModalTitle id="exampleModalLabel">Parada </MDBModalTitle>
    </MDBModalHeader>
    <MDBModalBody>
            <div class="container-d">
              <div class="row">
                <div class="col-12 mb-3 autocomplete-container ">
                  <label>Dirección</label>
                    <div class="input-group flex-nowrap">
                      <input
                      type="text"
                      class="form-control" 
                      placeholder="Ingresa la dirección" 
                      id="address-input"  
                      v-model="searchQueryStopover"
                      @input="updateSearchStopover()"
                      />
                      <span class="input-group-text" id="password-input" style="cursor:pointer;">
                        <i class="fas fa-search"></i>
                      </span>
                  </div>
                  <ul class="list-group autocomplete-list">
                    <li class="autocomplete-list-item" v-for="place in placesSearchedStopover" :key="place.id" @click="selectPlaceStopover(place)">{{ place.description }}</li>
                  </ul>
                
                </div>
                  <hr class="horizontal dark" />
                <div class="col-12">
                  <GMapMap
                    :center="centerStopover"
                    ref="myMapRef"
                    :zoom="zoom"
                    @click="onMapClickStopover"
                    style="height: 20rem"
                    :options="mapOptions"
                  >
                    <GMapMarker
                      v-if="startPositionStopover"
                      :position="startPositionStopover.position"
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
            <button  class="btn bg-gradient-secondary me-2" @click="closeModalNewRouteStopover()">Cancelar</button>
            <button  class="btn bg-gradient-dark" @click="selectAddressStopover()">Seleccionar</button>
          </div>
        </div>
      </div>
    </MDBModalFooter>
  </MDBModal>


  <MDBModal
    id="newRouteEndPositionModal"
    tabindex="-1"
    labelledby="newRouteEndPositionModalLabel"
    v-model="exampleModalStopoverUpdate"
  >
    <MDBModalHeader>
      <MDBModalTitle id="exampleModalLabel">Actualizar Parada </MDBModalTitle>
    </MDBModalHeader>
    <MDBModalBody>
            <div class="container-d">
              <div class="row">
                <div class="col-12 mb-3 autocomplete-container ">
                  <label>Dirección</label>
                    <div class="input-group flex-nowrap">
                      <input
                      type="text"
                      class="form-control" 
                      placeholder="Ingresa la dirección" 
                      id="address-input"  
                      v-model="searchQueryStopoverUpdate"
                      @input="updateSearchStopoverUpdate()"
                      />
                      <span class="input-group-text" id="password-input" style="cursor:pointer;">
                        <i class="fas fa-search"></i>
                      </span>
                  </div>
                  <ul class="list-group autocomplete-list">
                    <li class="autocomplete-list-item" v-for="place in placesSearchedStopoverUpdate" :key="place.id" @click="selectPlaceStopoverUpdate(place)">{{ place.description }}</li>
                  </ul>
                
                </div>

                <div class="col-12">
                  <hr class="horizontal dark" />
                  <GMapMap
                    :center="centerStopoverUpdate"
                    ref="myMapRef"
                    :zoom="zoom"
                    @click="onMapClickStopoverUpdate"
                    style="height: 20rem"
                    :options="mapOptions"
                  >
                    <GMapMarker
                      v-if="startPositionStopoverUpdate"
                      :position="startPositionStopoverUpdate.position"
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
            <button  class="btn bg-gradient-secondary me-2" @click="closeModalNewRouteStopoverUpdate()">Cancelar</button>
            <button  class="btn bg-gradient-dark" @click="selectAddressStopoverUpdate()">Seleccionar</button>
          </div>
        </div>
      </div>
    </MDBModalFooter>
  </MDBModal>
</template>

<script>
import mapFunctions from '../../../../kernel/map-functions/maps'
import routeValidator from '../../../../kernel/validators/route.validator'
import Loader from '../../../../components/Loader.vue'
import DataTable from 'datatables.net-dt';
//import { DataTable } from "simple-datatables";
import $ from 'jquery';
import newRoute from '../../use-cases/new.route'
import router from '../../../../router/index'

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
    Loader,
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
      centerStopover:{},
      centerStopoverUpdate:{},
      zoom: 12,
      startPositionStopover: null,
      startPositionStopoverUpdate: null,
      exampleModal:false,
      exampleModalEnd: false,
      exampleModalStopover: false,
      exampleModalStopoverUpdate: false,
      mapOptions: {
        disableDefaultUI: true, 
      },
      searchQueryStopover:"",
      searchQueryStopoverUpdate:"",
      placesSearchedStopover: [],
      placesSearchedStopoverUpdate: [],
      geocoder: {},
      isLoading: false,
      route:{
        name: '',
        stopOvers:[
        ]
      },
      defaultAddressStart: '',
      defaultAddressEnd: '',
      defaultAddressStopover: '',
      defaultAddressStopoverUpdate: '',
      errors:{
        name: '',
        stopovers: '',
      },
      stopover:{},
      stopoverUpdate:{},
      datatable:null,
    };
  },
  mounted() {
   this.initializaDatatable();
  },
  methods: {
    cancelar(){
         router.push({name: 'Consultar Rutas'})
    },
    initializaDatatable(){
      if(this.datatable){
        this.datatable.destroy()
      }
      this.$nextTick(()=>{
        this.datatable =  new DataTable('#tableStopOvers', {
          searching: true,
          ordering: true,
          pageLength:5,
          lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "Mostrar todos"]],
          language:{
            infoEmpty: "",
            url: 'https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json',
            paginate: {
                    next: ">"
                },
            search: "",
            searchPlaceholder: "Buscar...",
            
          },
          pagingType: "simple_numbers",
          drawCallback: ()=>{
                $('#tableStopOvers_previous').addClass('d-none');
          },
          columnDefs: [
                {
                    targets: [0, 1, 2], // Índices de las columnas que deben ser visibles
                    visible: true
                }
          ]
          });
      })
      
    },
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

    async onMapClickStopover(event) {
      const latLng = event.latLng; 
      mapFunctions.getGeocode(latLng).then((response) =>{
        let isMexico = mapFunctions.isPlaceInMexico(response);
        if(isMexico){
          const {formatted_address} = response
          this.searchQueryStopover = formatted_address
          this.stopover.state = mapFunctions.getStateFromResult(response);
          this.stopover.lat = latLng.lat();
          this.stopover.lng = latLng.lng();
          this.stopover.latLng = latLng;
        }else{
          this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
        }
      }).catch((err)=>{
        this.$swal({icon: "error", title: err,type: "basic"});
      })
      

      this.startPositionStopover= { position: { lat: latLng.lat(), lng: latLng.lng()} };
    },
    async onMapClickStopoverUpdate(event) {
      const latLng = event.latLng; 
      mapFunctions.getGeocode(latLng).then((response) =>{
        let isMexico = mapFunctions.isPlaceInMexico(response);
        if(isMexico){
          const {formatted_address} = response
          this.searchQueryStopoverUpdate = formatted_address
          this.stopoverUpdate.state = mapFunctions.getStateFromResult(response);
          this.stopoverUpdate.lat = latLng.lat();
          this.stopoverUpdate.lng = latLng.lng();
          this.stopoverUpdate.latLng = latLng;
        }else{
          this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
        }
      }).catch((err)=>{
        this.$swal({icon: "error", title: err,type: "basic"});
      })
      

      this.startPositionStopoverUpdate= { position: { lat: latLng.lat(), lng: latLng.lng()} };
    },

    openModalStopover(){
      this.isLoading = true;

      mapFunctions.getCurrentPosition().then( async (response) =>{
      this.centerStopover = {lat: response.coords.latitude, lng: response.coords.longitude}

      let position = await  mapFunctions.convertLatLng(this.centerStopover.lat, this.centerStopover.lng)
      this.stopover = {...this.centerStopover};
      this.stopover.latLng = position;

      let result = await mapFunctions.getGeocode(position)
      if(mapFunctions.isPlaceInMexico(result)){
          this.searchQueryStopover = await mapFunctions.getAddressByLatLng(position);
          this.stopover.state = mapFunctions.getStateFromResult(result);
          this.defaultAddressStopover = this.searchQueryStopover
          this.isLoading = false;
          this.exampleModalStopover = true
          this.startPositionStopover = {position: {...this.centerStopover}}
      }else{
          this.isLoading = false;
          this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
      } 

    }).catch((err)=>{
      this.isLoading = false;
      this.$swal({ icon: "error", title: err,type: "basic"});
    })

    },
    updateStopover(stopover){
      this.openModalStopoverUpdate(stopover);
    },
    openModalStopoverUpdate(stopover){
      this.isLoading = true;

      const {lat, lng, description} = stopover
      this.searchQueryStopoverUpdate = description
      this.defaultAddressStopoverUpdate = description
      this.startPositionStopoverUpdate = {position: {lat, lng}};
      this.centerStopoverUpdate = {lat, lng}
      this.stopoverUpdate = {...stopover};
      this.isLoading = false
      this.exampleModalStopoverUpdate = true;

    },
    async updateSearchStopover() {
       const {AutocompleteService} = await window.google.maps.importLibrary("places")
       const instance = new AutocompleteService();
       if(this.searchQueryStopover && this.searchQueryStopover !== '' && this.searchQueryStopover != undefined){
            instance.getQueryPredictions({ input: this.searchQueryStopover }, (predictions) =>{
              this.placesSearchedStopover = predictions;
            })
       }else{
        this.placesSearchedStopover = [];
       }
    },
    async updateSearchStopoverUpdate() {
       const {AutocompleteService} = await window.google.maps.importLibrary("places")
       const instance = new AutocompleteService();
       if(this.searchQueryStopoverUpdate && this.searchQueryStopoverUpdate !== '' && this.searchQueryStopoverUpdate != undefined){
            instance.getQueryPredictions({ input: this.searchQueryStopoverUpdate }, (predictions) =>{
              this.placesSearchedStopoverUpdate = predictions;
            })
       }else{
        this.placesSearchedStopoverUpdate = [];
       }
    },

    async selectPlaceStopover(place){
      const {place_id, description} = place
      this.placesSearchedStopover = [];
      const geocoder = new window.google.maps.Geocoder();
      geocoder.geocode({ placeId: place_id }, (results, status) => {
        if (status === "OK") {
          if (results[0]) {
            let isMexico = mapFunctions.isPlaceInMexico(results[0])
            if(isMexico){
              this.searchQueryStopover = description;
              let address =  results[0].geometry.location;
              this.centerStopover = { lat: address.lat() , lng: address.lng()}
              this.stopover = {...this.centerStopover};
              this.stopover.state = mapFunctions.getStateFromResult(results[0]);
              this.startPositionStopover = { position: { lat: address.lat(), lng: address.lng()} };
            }else{
                this.searchQueryStopover= this.defaultAddressStopover;
                this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
            }
          } else {
            this.$swal({icon: "error", title: 'No se encontraron resultados de geocodificación.', type: "basic" });
          }
        } else {
          this.$swal({icon: "error", title: 'Error en la solicitud de geocodificación', type: "basic" });
        }
      });
      
    },
    async selectPlaceStopoverUpdate(place){
      const {place_id, description} = place
      this.placesSearchedStopoverUpdate = [];
      const geocoder = new window.google.maps.Geocoder();
      geocoder.geocode({ placeId: place_id }, (results, status) => {
        if (status === "OK") {
          if (results[0]) {
            let isMexico = mapFunctions.isPlaceInMexico(results[0])
            if(isMexico){
              this.searchQueryStopoverUpdate = description;
              let address =  results[0].geometry.location;
              this.centerStopoverUpdate = { lat: address.lat() , lng: address.lng()}
              this.stopoverUpdate = {...this.centerStopoverUpdate};
              this.startPositionStopoverUpdate = { position: { lat: address.lat(), lng: address.lng()} };
              this.stopoverUpdate.state = mapFunctions.getStateFromResult(results[0]);
            }else{
                this.searchQueryStopoverUpdate= this.defaultAddressStopoverUpdate;
                this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
            }
          } else {
            this.$swal({icon: "error", title: 'No se encontraron resultados de geocodificación.', type: "basic" });
          }
        } else {
          this.$swal({icon: "error", title: 'Error en la solicitud de geocodificación', type: "basic" });
        }
      });
      
    },

    closeModalNewRouteStopover(){
      this.exampleModalStopover = false;
      this.searchQueryStopover= "";
      this.startPositionStopover = {};
      this.centerStopover = {};
    },
    closeModalNewRouteStopoverUpdate(){
      this.exampleModalStopoverUpdate = false;
      this.searchQueryStopoverUpdate= "";
      this.startPositionStopoverUpdate = {};
      this.centerStopoverUpdate = {};
    },

    selectAddressStopover(){
      const response = routeValidator.isSameStopOver(this.route.stopOvers, this.stopover.lat, this.stopover.lng);

      if(response){
        this.$swal({icon: "info", title:response, type: "basic" });
      }else{
          this.route.stopOvers.push({description: this.searchQueryStopover, sequence: this.route.stopOvers.length + 1  , ...this.stopover})
          this.closeModalNewRouteStopover();
          this.initializaDatatable()
      }

    },
    selectAddressStopoverUpdate(){
      const response = routeValidator.isSameStopOver(this.route.stopOvers, this.stopoverUpdate.lat, this.stopoverUpdate.lng);

      if(response){
        this.$swal({icon: "info", title:response, type: "basic" });
      }else{
           this.route.stopOvers = [... this.route.stopOvers.map((stopover) =>{
              if(stopover.sequence === this.stopoverUpdate.sequence){
                stopover = {...this.stopoverUpdate, description: this.searchQueryStopoverUpdate};
              }
              return stopover;
           })]
          this.initializaDatatable()
          this.closeModalNewRouteStopoverUpdate();
      }

    },
    deleteStopover(sequence){
      this.route.stopOvers = [...this.route.stopOvers.filter(stopover => stopover.sequence !== sequence)]
      if(this.route.stopOvers.length > 0){
        this.route.stopOvers = [...this.route.stopOvers.map((stopover, index)=>{
        stopover.sequence = index+1;
        return stopover;
        })]
      }
      this.initializaDatatable()
     
    },
    async preNewRoute(){
      this.initializaDatatable()
      this.errors.name = routeValidator.validateName(this.route.name);
      this.errors.stopovers = routeValidator.validateStopovers(this.route.stopOvers);
      if(!this.errors.name && !this.errors.stopovers){
            try{
            let meters = await mapFunctions.getMetersBetweenTwoDirections(this.route.stopOvers[0].description,this.route.stopOvers[(this.route.stopOvers.length -1)].description);
            let time = await mapFunctions.getTimeBetweenTwoDirections(this.route.stopOvers[0].description,this.route.stopOvers[(this.route.stopOvers.length -1)].description);
            const payload = {
              name: this.route.name,
              meters: parseFloat(meters),
              time: time
            }

            payload.stopOvers = await Promise.all([...this.route.stopOvers.map(async (stopover) =>{
              stopover = {description: stopover.description, latitude: stopover.lat, longitude: stopover.lng, sequence: stopover.sequence, state: stopover.state}

              mapFunctions.getMetersBetweenTwoDirections(this.route.stopOvers[0].description,stopover.description).then((response) =>{
                  stopover.meters = parseFloat(response)
              });
              mapFunctions.getTimeBetweenTwoDirections(this.route.stopOvers[0].description,stopover.description).then((response) =>{
                stopover.time = parseFloat(response)
              });
              return stopover;
            })])


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
                  const {message, error, data} =  await newRoute(payload);
                  this.isLoading = false;
                  if(!error){
                    const {result:{text}} = data
                    this.$swal({
                      icon: "success",
                      title: message,
                      text: text,
                      type: 'success-message',
                    });
                    router.push({name: 'Consultar Rutas'})
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


            }catch(err){
              this.$swal({icon: "error", title:err, type: "basic" });
            }
      }
      
    },
   
    
  },
  emits: ['position_changed'],
};
</script>

<style scoped>
.autocomplete-container {
            position: relative;
        }

.autocomplete-list {
            position: absolute;
            z-index: 1000;
            width: 95%;
            max-height: 200px;
            overflow-y: auto;
            border: 1px solid white;
            border-radius: 0 0 5px 5px;
            margin-top: 5px;
            background-color: #fff;
        }

        .autocomplete-list-item {
            list-style: none;
            padding: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .autocomplete-list-item:hover {
            background-color: #f8f9fa;
        }
</style>