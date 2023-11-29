<template>
<Loader :isLoading="isLoading"/>
  <div class="container-fluid">
    <div class="row">
      <div class=" col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row mx-2" >
            <div class="col-12 col-lg-6 mb-3">
              <label>Punto de inicio(<span class="text-danger">*</span>)</label>
                <div class="input-group flex-nowrap">
                  <input
                  type="text"
                  class="form-control" 
                  placeholder="Ingresa la dirección" 
                  id="password-input"
                  v-cloak
                  :value="route?.startAddress?.description"  
                  />
                  <span class="input-group-text" id="password-input" @click="openModalStart()" style="cursor:pointer;">
                    <i class="fa fa-map-marker"></i>
                  </span>
                   
              </div>
              <div v-if="errors.startPosition" style="color: red">
                      {{ errors.startPosition }}
              </div>
            </div>
            <div class="col-12 col-lg-6">
              <label>Destino(<span class="text-danger">*</span>)</label>
               <div class="input-group flex-nowrap">
                  <input
                  type="text"
                  class="form-control" 
                  placeholder="Ingresa la dirección" 
                  id="password-input" 
                  :value="route?.endAddress?.description"  
                  />
                  <span class="input-group-text" id="password-input" @click="openModalEnd()" style="cursor:pointer;">
                    <i class="fa fa-map-marker"></i>
                  </span>
              </div>
                  <div  v-if="errors.endPosition" style="color: red">
                      {{ errors.endPosition }}
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
                      <button class="mb-0 btn bg-gradient-primary btn-sm" @click="openModalStopover()">+&nbsp; Nueva Parada</button>
                    </div>
                  </div>
                </div>
            </div>
            <div class="col-12 table-responsive mt-3">
              <table class="table table-flush" id="tableStopOvers" >
                <thead class="thead-light">
                    <tr>
                      <th style="font-size: 0.65em; font-weight: bold; text-align: start">#</th>
                      <th style="font-size: 0.65em; font-weight: bold">DIRECCIÓN</th>
                      <th style="font-size: 0.65em; font-weight: bold">ACCIONES</th>
                    </tr>
                </thead>
                <tbody id="tablebody">
                  <tr  v-for="({address, sequence, id}, index) in route.stopOvers" :key="index">
                    <td v-text="index + 1 "></td>
                    <td>{{address.description}}</td>
                    <td>
                      <a
                        class="me-2"
                        @click="updateStopover({description: address.description,lat: address.latitude, lng:address.longitude, id:id, sequence})"
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
            </div>
            <div class="col-12 mt-3 text-end ">
              <button
                class="btn bg-secondary-gradient me-2"
                title="Cancelar"
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
    id="newRouteStartPositionModal"
    tabindex="-1"
    labelledby="newRouteStartPositionModalLabel"
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
                      v-model="searchQueryStart"
                      @input="updateSearchStart()"
                      />
                      <span class="input-group-text" id="password-input" style="cursor:pointer;">
                        <i class="fas fa-search"></i>
                      </span>
                  </div>
                  <ul>
                    <li v-for="place in placesSearchedStart" :key="place.id" @click="selectPlaceStart(place)">{{ place.description }}</li>
                  </ul>
                
                </div>
                  <hr class="horizontal dark" />
                <div class="col-12">
                  <GMapMap
                    :center="centerStart"
                    ref="myMapRef"
                    :zoom="zoom"
                    @click="onMapClickStart"
                    style="height: 20rem"
                    :options="mapOptions"
                  >
                    <GMapMarker
                      v-if="startPositionStart"
                      :position="startPositionStart.position"
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
            <button  class="btn bg-gradient-secondary me-2" @click="closeModalNewRouteStart()">Cancelar</button>
            <button  class="btn bg-gradient-dark" @click="selectAddressStart()">Seleccionar</button>
          </div>
        </div>
      </div>
    </MDBModalFooter>
  </MDBModal>

  <MDBModal
    id="newRouteEndPositionModal"
    tabindex="-1"
    labelledby="newRouteEndPositionModalLabel"
    v-model="exampleModalEnd"
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
                      v-model="searchQueryEnd"
                      @input="updateSearchEnd()"
                      />
                      <span class="input-group-text" id="password-input" style="cursor:pointer;">
                        <i class="fas fa-search"></i>
                      </span>
                  </div>
                  <ul>
                    <li v-for="place in placesSearchedEnd" :key="place.id" @click="selectPlaceEnd(place)">{{ place.description }}</li>
                  </ul>
                
                </div>
                  <hr class="horizontal dark" />
                <div class="col-12">
                  <GMapMap
                    :center="centerEnd"
                    ref="myMapRef"
                    :zoom="zoom"
                    @click="onMapClickEnd"
                    style="height: 20rem"
                    :options="mapOptions"
                  >
                    <GMapMarker
                      v-if="startPositionEnd"
                      :position="startPositionEnd.position"
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
            <button  class="btn bg-gradient-secondary me-2" @click="closeModalNewRouteEnd()">Cancelar</button>
            <button  class="btn bg-gradient-dark" @click="selectAddressEnd()">Seleccionar</button>
          </div>
        </div>
      </div>
    </MDBModalFooter>
  </MDBModal>


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
                <div class="col-12 mb-3">
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
                  <ul>
                    <li v-for="place in placesSearchedStopover" :key="place.id" @click="selectPlaceStopover(place)">{{ place.description }}</li>
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
                <div class="col-12 mb-3">
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
                  <ul>
                    <li v-for="place in placesSearchedStopoverUpdate" :key="place.id" @click="selectPlaceStopoverUpdate(place)">{{ place.description }}</li>
                  </ul>
                
                </div>
                  <hr class="horizontal dark" />
                <div class="col-12">
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
import updateRoute from '../../use-cases/update.route'
import getRoute from '../../use-cases/get.route'
import router from '../../../../router/index'

 import {
    MDBModal,
    MDBModalBody,
    MDBModalHeader,
    MDBModalTitle,
    MDBModalFooter
  } from 'mdb-vue-ui-kit';

export default {
  name: "UpdateRoute",
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
      centerStart:{},
      centerEnd:{},
      centerStopover:{},
      centerStopoverUpdate:{},
      zoom: 12,
      startPositionStart: null,
      startPositionEnd: null,
      startPositionStopover: null,
      startPositionStopoverUpdate: null,
      exampleModal:false,
      exampleModalEnd: false,
      exampleModalStopover: false,
      exampleModalStopoverUpdate: false,
      mapOptions: {
        disableDefaultUI: true, 
      },
      searchQueryStart:"",
      searchQueryEnd:"",
      searchQueryStopover:"",
      searchQueryStopoverUpdate:"",
      placesSearchedStart: [],
      placesSearchedEnd: [],
      placesSearchedStopover: [],
      placesSearchedStopoverUpdate: [],
      geocoder: {},
      isLoading: false,
      route:{},
      defaultAddressStart: '',
      defaultAddressEnd: '',
      defaultAddressStopover: '',
      defaultAddressStopoverUpdate: '',
      errors:{
        endPosition: '',
        startPosition: '',
      },
      stopover:{

      },
      stopoverUpdate:{

      },
      datatable:null,
      idRoute: 0,
      routeOriginal: {},
    };
  },
  async beforeMount(){
    this.idRoute = this.$route.params.id;
    await this.getRoute(this.idRoute)
    this.initializaDatatable();
  },
  async mounted() {
  },
  methods: {
    async getRoute(id){
      this.isLoading = true;
      const response = {...await getRoute(id)};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.route = result;
          this.routeOriginal = {...result}
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
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
    async onMapClickStart(event) {
      const latLng = event.latLng; 
      mapFunctions.getGeocode(latLng).then((response) =>{
        let isMexico = mapFunctions.isPlaceInMexico(response);
        if(isMexico){
          const {formatted_address} = response
          this.searchQueryStart = formatted_address
          this.route.startAddress.state = mapFunctions.getStateFromResult(response);
          this.route.startAddress.latitude = latLng.lat();
          this.route.startAddress.longitude = latLng.lng();
          this.route.startAddress.latLng = latLng;
        }else{
          this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
        }
      }).catch((err)=>{
        this.$swal({icon: "error", title: err,type: "basic"});
      })
      

      this.startPositionStart = { position: { lat: latLng.lat(), lng: latLng.lng()} };
    },
    async onMapClickEnd(event) {
        const latLng = event.latLng; 
        mapFunctions.getGeocode(latLng).then((response) =>{
        let isMexico = mapFunctions.isPlaceInMexico(response);
        if(isMexico){
          const {formatted_address} = response
          this.searchQueryEnd = formatted_address
          this.route.endAddress.state = mapFunctions.getStateFromResult(response);
          this.route.endAddress.latitude = latLng.lat();
          this.route.endAddress.longitude = latLng.lng();
          this.route.endAddress.latLng = latLng;
        }else{
          this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
        }
      }).catch((err)=>{
        this.$swal({icon: "error", title: err,type: "basic"});
      })
      

      this.startPositionEnd= { position: { lat: latLng.lat(), lng: latLng.lng()} };
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
    openModalStart(){
      this.isLoading = true;
      if(!(this.route.startAddress.description != '' && this.route.startAddress.description  != null)){
            mapFunctions.getCurrentPosition().then( async (response) =>{
            this.centerStart = {lat: response.coords.latitude, lng: response.coords.longitude}

            let position = await  mapFunctions.convertLatLng(this.centerStart.lat, this.centerStart.lng)
            this.route.startAddress = {...this.route.startAddress, latitude: this.centerStart.lat, longitude: this.centerStart.lng};
             this.route.startAddress.latLng = position;

            let result = await mapFunctions.getGeocode(position)
            if(mapFunctions.isPlaceInMexico(result)){
                this.searchQueryStart = await mapFunctions.getAddressByLatLng(position);
                this.route.startAddress.state = mapFunctions.getStateFromResult(result);
                this.defaultAddressStart = this.searchQueryStart
                this.isLoading = false;
                this.exampleModal = true
                this.startPositionStart = {position: {...this.centerStart}}
            }else{
                this.isLoading = false;
                this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
            } 

          }).catch((err)=>{
          this.isLoading = false;
          this.$swal({ icon: "error", title: err,type: "basic"});
          })
      }else{
        const {latitude, longitude, description} = this.route.startAddress
        this.searchQueryStart = description
        this.defaultAddressStart = description
        this.startPositionStart = {position: {lat: parseFloat(latitude), lng: parseFloat(longitude)}};
        this.centerStart = {lat: parseFloat(latitude), lng: parseFloat(longitude)}
        this.isLoading = false
        this.exampleModal = true;
      }
    },
    openModalEnd(){
      this.isLoading = true;
      if(!(this.route.endAddress.description != '' && this.route.endAddress.description != null)){
            mapFunctions.getCurrentPosition().then( async (response) =>{
            this.centerEnd = {lat: response.coords.latitude, lng: response.coords.longitude}

            let position = await  mapFunctions.convertLatLng(this.centerEnd.lat, this.centerEnd.lng)
            this.route.endAddress = {...this.route.endAddress, latitude: this.centerEnd.lat, longitude: this.centerEnd.lng};
            this.route.endAddress.latLng = position;

            let result = await mapFunctions.getGeocode(position)
            if(mapFunctions.isPlaceInMexico(result)){
                this.searchQueryEnd = await mapFunctions.getAddressByLatLng(position);
                this.route.endAddress.state = mapFunctions.getStateFromResult(result);
                this.defaultAddressEnd = this.searchQueryEnd
                this.isLoading = false;
                this.exampleModalEnd = true
                this.startPositionEnd = {position: {...this.centerEnd}}
            }else{
                this.isLoading = false;
                this.$swal({icon: "info", title: 'El lugar se encuentra fuera de México', type: "basic" });
            } 

          }).catch((err)=>{
          this.isLoading = false;
          this.$swal({ icon: "error", title: err,type: "basic"});
          })
      }else{
        const {latitude, longitude, description} = this.route.endAddress
        this.searchQueryEnd = description
        this.defaultAddressEnd = description
        this.startPositionEnd = {position: {lat:parseFloat(latitude), lng: parseFloat(longitude)}};
        this.centerEnd = {lat:parseFloat(latitude), lng: parseFloat(longitude)}
        this.isLoading = false
        this.exampleModalEnd = true;
      }
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
      this.startPositionStopoverUpdate = {position: {lat: parseFloat(lat),lng: parseFloat(lng)}};
      this.centerStopoverUpdate = {lat: parseFloat(lat),lng: parseFloat(lng)}
      this.stopoverUpdate = {...stopover};
      this.isLoading = false
      this.exampleModalStopoverUpdate = true;

    },
    async updateSearchStart() {
       const {AutocompleteService} = await window.google.maps.importLibrary("places")
       const instance = new AutocompleteService();
       if(this.searchQueryStart && this.searchQueryStart !== '' && this.searchQueryStart != undefined){
            instance.getQueryPredictions({ input: this.searchQueryStart }, (predictions) =>{
              this.placesSearchedStart = predictions;
            })
       }else{
        this.placesSearchedStart = [];
       }
    },
    async updateSearchEnd() {
       const {AutocompleteService} = await window.google.maps.importLibrary("places")
       const instance = new AutocompleteService();
       if(this.searchQueryEnd && this.searchQueryEnd !== '' && this.searchQueryEnd != undefined){
            instance.getQueryPredictions({ input: this.searchQueryEnd }, (predictions) =>{
              this.placesSearchedEnd = predictions;
            })
       }else{
        this.placesSearchedEnd = [];
       }
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
    async selectPlaceStart(place){
      const {place_id, description} = place
      this.placesSearchedStart = [];
      const geocoder = new window.google.maps.Geocoder();
      geocoder.geocode({ placeId: place_id }, (results, status) => {
        if (status === "OK") {
          if (results[0]) {
            let isMexico = mapFunctions.isPlaceInMexico(results[0])
            if(isMexico){
              this.searchQueryStart = description;
              let address =  results[0].geometry.location;
              this.centerStart = { lat: address.lat() , lng: address.lng()}
              this.route.startAddress = {... this.route.startAddress, latitude: this.centerStart.lat, longitude: this.centerStart.lng};
              this.startPositionStart = { position: { lat: address.lat(), lng: address.lng()} };
            }else{
                this.searchQueryStart = this.defaultAddressStart;
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
    async selectPlaceEnd(place){
      const {place_id, description} = place
      this.placesSearchedEnd = [];
      const geocoder = new window.google.maps.Geocoder();
      geocoder.geocode({ placeId: place_id }, (results, status) => {
        if (status === "OK") {
          if (results[0]) {
            let isMexico = mapFunctions.isPlaceInMexico(results[0])
            if(isMexico){
              this.searchQueryEnd = description;
              let address =  results[0].geometry.location;
              this.centerEnd = { lat: address.lat() , lng: address.lng()}
              this.route.endAddress = {...this.route.endAddress, longitude: this.centerEnd.lng, latitude: this.centerEnd.lat};
              this.startPositionEnd = { position: { lat: address.lat(), lng: address.lng()} };
            }else{
                this.searchQueryEnd = this.defaultAddressEnd;
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
              this.stopover = {...this.centerEnd};
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
              this.stopoverUpdate = {...this.stopoverUpdate, address: {...this.stopoverUpdate.address,...this.centerStopoverUpdate}};
              this.startPositionStopoverUpdate = { position: { lat: address.lat(), lng: address.lng()} };
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
    closeModalNewRouteStart(){
      this.exampleModal = false;
      this.searchQueryStart = "";
      this.startPositionStart = {};
      this.centerStart = {};
    },
    closeModalNewRouteEnd(){
      this.exampleModalEnd = false;
      this.searchQueryEnd = "";
      this.startPositionEnd = {};
      this.centerEnd = {};
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
    selectAddressStart(){
      this.route.startAddress.description = this.searchQueryStart;
      this.closeModalNewRouteStart();
    },
    selectAddressEnd(){
      this.route.endAddress.description = this.searchQueryEnd;
      this.closeModalNewRouteEnd();
    },
    selectAddressStopover(){
      const response = routeValidator.isSameStopOver(this.route.stopOvers, this.stopover.lat, this.stopover.lng);

      if(response){
        this.$swal({icon: "info", title:response, type: "basic" });
      }else{
        this.route.stopOvers.push({id: null,
                              sequence: this.route.stopOvers.length + 1 ,
                              address:{ longitude: this.stopover.lng, latitude: this.stopover.lat, description: this.searchQueryStopover, state: this.stopover.state }
                              })
        this.initializaDatatable()
        this.closeModalNewRouteStopover();
      }

    },
    selectAddressStopoverUpdate(){
      const response = routeValidator.isSameStopOver(this.route.stopOvers, this.stopoverUpdate.lat, this.stopoverUpdate.lng);

      if(response){
        this.$swal({icon: "info", title:response, type: "basic" });
      }else{
           this.route.stopOvers = [... this.route.stopOvers.map((stopover) =>{
              if(stopover.id){
                if(stopover.id === this.stopoverUpdate.id){
                  stopover = {id: this.stopoverUpdate.id,
                              sequence: this.stopoverUpdate.sequence,
                              address:{ longitude: this.stopoverUpdate.lng, latitude: this.stopoverUpdate.lat, description: this.searchQueryStopoverUpdate, state: this.stopoverUpdate.state }
                              }
                }
              }else{
                if(stopover.sequence === this.stopoverUpdate.sequence){
                  stopover = {id: this.stopoverUpdate.id,
                              sequence: this.stopoverUpdate.sequence,
                              address:{ longitude: this.stopoverUpdate.lng, latitude: this.stopoverUpdate.lat, description: this.searchQueryStopoverUpdate, state: this.stopoverUpdate.state }
                              }
                }
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
    modificar(){
    },
    async preNewRoute(){
      this.errors.startPosition = routeValidator.validateAddressUpdate(this.route.startAddress);
      this.errors.endPosition = routeValidator.validateAddressUpdate(this.route.endAddress);
      if(!this.errors.startPosition && !this.errors.endPosition){
        this.errors.startPosition = routeValidator.isSameAddress(this.route.startAddress.latitude,this.route.endAddress.latitude, this.route.startAddress.longitude, this.route.endAddress.longitude);
        this.errors.endPosition = routeValidator.isSameAddress(this.route.startAddress.latitude,this.route.endAddress.latitude, this.route.startAddress.longitude, this.route.endAddress.longitude);
      }

      if(!this.errors.startPosition && !this.errors.endPosition){
         const response = routeValidator.isSameAddressesRegardingEndAndStartUpdate(this.route.stopOvers, this.route.startAddress, this.route.endAddress);
          if(!response){
            try{
            let meters = await mapFunctions.getMetersBetweenTwoDirections(this.route.startAddress.description,this.route.endAddress.description);
            let time = await mapFunctions.getTimeBetweenTwoDirections(this.route.startAddress.description,this.route.endAddress.description);
            const payload = {
              id: this.route.id,
              startAddress: {
                description: this.route.startAddress.description,
                latitude: this.route.startAddress.latitude,
                longitude: this.route.startAddress.longitude,
                state: this.route.startAddress.state.name ? this.route.startAddress.state.name : this.route.startAddress.state
              },
              endAddress:{
                description: this.route.endAddress.description,
                latitude: this.route.endAddress.latitude,
                longitude: this.route.endAddress.longitude,
                state: this.route.endAddress.state.name ? this.route.endAddress.state.name : this.route.endAddress.state
              },
              meters: parseFloat(meters),
              time: time
            }

            payload.stopOvers = await Promise.all([...this.route.stopOvers.map(async (stopover) =>{
              stopover = {description: stopover.address.description, latitude: stopover.address.latitude, longitude: stopover.address.longitude, sequence: stopover.sequence, state: stopover.address.state.name ?  stopover.address.state.name : stopover.address.state}
              mapFunctions.getMetersBetweenTwoDirections(payload.startAddress.description,stopover.description).then((response) =>{
                  stopover.meters = parseFloat(response)
              });
              mapFunctions.getTimeBetweenTwoDirections(payload.endAddress.description,stopover.description).then((response) =>{
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
              const {message, error, data} =  await updateRoute(payload);
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
          }else{
            this.$swal({icon: "warning", title:response, type: "basic" });
          }
      }
      
    },
   
    
  },
  emits: ['position_changed'],
};
</script>

