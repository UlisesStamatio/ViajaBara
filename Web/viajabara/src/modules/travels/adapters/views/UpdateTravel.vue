<template>
<Loader :isLoading="isLoading"/>
  <div class="container-fluid" v-show="!isLoading">
    <div class="row">
      <div class="mx-auto col-lg-12 col-12">
        <div class="mt-4 card card-body">
          <h6 class="mb-0">Información básica</h6>
          <hr class="my-3 horizontal dark" />
          <div class="row">
            <div class="col-12 col-lg-6 mb-3 ">
              <label>Conductor(<span class="text-danger">*</span>)</label>
                  <VueMultiselect
                    v-model="searchedTrip.driver"
                    :options="drivers"
                    selectLabel="Presiona para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presiona para remover"
                    placeholder="Buscar.."
                    label="name"
                    :class="{'isInvalid': errors.driver, 'isValid': errors.driver === null}"
                    >
                    <template #noResult>
                      Elemento no encontrado.
                    </template>
                  </VueMultiselect>
              <div v-if="errors.driver" style="color: red">
                      {{ errors.driver }}
              </div>
            </div>
            <div class="col-12 col-lg-6 mb-3">
              <label>Unidad(<span class="text-danger">*</span>)</label>
                <VueMultiselect
                    v-model="searchedTrip.bus"
                    :options="buses"
                    selectLabel="Presiona para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presiona para remover"
                    placeholder="Buscar.."
                    label="plaque"
                    :class="{'isInvalid': errors.bus, 'isValid': errors.bus === null}"
                    >
                     <template #noResult>
                      Elemento no encontrado.
                    </template>
                  </VueMultiselect>
              <div v-if="errors.bus" style="color: red">
                    {{ errors.bus }}
              </div>
            </div>

            <div class="col-12 col-lg-6 mb-3">
              <label>Hora(<span class="text-danger">*</span>)</label>
              <input type="time" class="form-control" id="date" name="date" v-model="searchedTrip.startTime" :class="{ 'is-invalid': errors.date, 'is-valid': errors.date === null }">
              <div v-if="errors.date" style="color: red">
                    {{ errors.date }}
              </div>
            </div>


              <div class="col-12 col-lg-6 mb-3">
              <label>Días(<span class="text-danger">*</span>)</label>
               <VueMultiselect
                    v-model="searchedTrip.workDays"
                    :options="days" 
                    :multiple="true" 
                    :close-on-select="false" 
                    :clear-on-select="false" 
                    :preserve-search="true" 
                    label="label" 
                    track-by="value" 
                    :preselect-first="false"
                    selectLabel="Presiona para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presiona para remover"
                    placeholder="Buscar.."
                    :class="{'isInvalid': errors.day, 'isValid': errors.day === null}"
                    >
                     <template #noResult>
                      Elemento no encontrado.
                    </template>
                  </VueMultiselect>
                <div v-if="errors.day" style="color: red">
                    {{ errors.day }}
              </div>
            </div>
            <hr class="my-4 horizontal dark" />
            <div class="col-12 mb-2">
                <div class="d-lg-flex">
                  <div>
                    <h5 class="mb-0">Rutas (<span class="text-danger">*</span>)</h5>
                  </div>
                  <div class="my-auto mt-4 ms-auto mt-lg-0">
                    <div class="my-auto ms-auto">
                      <button class="mb-0 btn bg-gradient-danger btn-sm" @click="openModalNewRoute()">+&nbsp; Agregar Ruta</button>
                    </div>
                  </div>
                </div>
            </div>

            <div class="col-12 table-responsive mt-3">
              <table class="table table-flush" id="tableRoutes" >
                <thead class="thead-light">
                    <tr>
                      <th style="font-size: 0.65em; font-weight: bold; text-align: start">#</th>
                      <th style="font-size: 0.65em; font-weight: bold">Nombre</th>
                      <th style="font-size: 0.65em; font-weight: bold">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tablebody">
                  <tr v-for="(route, index) in routesSelected" :key="index">
                    <td>{{index + 1}}</td>
                    <td>{{route.name}}</td>
                    <td>
                      <a
                        class="me-2 clickeable"
                        @click="updateRoute(route.id)"
                        >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                        </a>

                        <a
                         class="clickeable"
                        @click="removeRoute(route.id)"
                        >
                        <i class="fa fa-times-circle text-secondary" ></i>
                        </a>
                    </td>
                  </tr>
                </tbody>
              </table>
              <div v-if="errors.ways" style="color: red">
                    {{ errors.ways }}
              </div>
            </div>



          </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">
                <button type="button" class="btn bg-gradient-secondary mb-0 me-2 ms-auto js-btn-next" @click="cancelar()" title="Cancelar">Cancelar</button>
                <button type="button" class="btn bg-gradient-dark mb-0 ms-auto js-btn-next" title="Guardar" @click="preUpdateTrip()">Guardar</button>
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
    v-model="newTripModal"
  >
    <MDBModalHeader>
      <MDBModalTitle id="exampleModalLabel">Agregar ruta</MDBModalTitle>
    </MDBModalHeader>
    <MDBModalBody>
            <div class="container-d">
              <div class="row">
                  <div class="col-12 mb-3">
                    <label>Ruta(<span class="text-danger">*</span>)</label>
                    <VueMultiselect
                          v-model="routeSelected"
                          :options="routes"
                          selectLabel="Presiona para seleccionar"
                          selectedLabel="Seleccionado"
                          deselectLabel="Presiona para remover"
                          placeholder="Buscar.."
                          label="name"
                           track-by="name" 
                          :class="{'isInvalid': modal.route, 'isValid': modal.route === null}"
                          >
                          <template #noResult>
                            Elemento no encontrado.
                          </template>
                        </VueMultiselect>
                    <div v-if="modal.route" style="color: red">
                          {{ modal.route }}
                    </div>
                  </div>
              </div>
            </div>

    </MDBModalBody>
    <MDBModalFooter >
      <div class="container-fluid">
        <div class="row">
          <div class="col-12 text-center">
            <button  class="btn bg-gradient-secondary me-2" @click="closeModalNewTrip()">Cancelar</button>
            <button  class="btn bg-gradient-dark" @click="addRoute()">Agregar</button>
          </div>
        </div>
      </div>
    </MDBModalFooter>
  </MDBModal>


    <MDBModal
    id="newRouteEndPositionModal"
    tabindex="-1"
    labelledby="newRouteEndPositionModalLabel"
    v-model="updateTripModal"
  >
    <MDBModalHeader>
      <MDBModalTitle id="exampleModalLabel">Actualizar ruta</MDBModalTitle>
    </MDBModalHeader>
    <MDBModalBody>
            <div class="container-d">
              <div class="row">
                  <div class="col-12 mb-3">
                    <label>Ruta(<span class="text-danger">*</span>)</label>
                    <VueMultiselect
                          v-model="routeSelectedUpdate"
                          :options="routes"
                          selectLabel="Presiona para seleccionar"
                          selectedLabel="Seleccionado"
                          deselectLabel="Presiona para remover"
                          placeholder="Buscar.."
                          label="name"
                           track-by="name" 
                          :class="{'isInvalid': modalUpdate.route, 'isValid': modalUpdate.route === null}"
                          >
                          <template #noResult>
                            Elemento no encontrado.
                          </template>
                        </VueMultiselect>
                    <div v-if="modalUpdate.route" style="color: red">
                          {{ modalUpdate.route }}
                    </div>
                  </div>
              </div>
            </div>

    </MDBModalBody>
    <MDBModalFooter >
      <div class="container-fluid">
        <div class="row">
          <div class="col-12 text-center">
            <button  class="btn bg-gradient-secondary me-2" @click="closeModalUpdateTrip()">Cancelar</button>
            <button  class="btn bg-gradient-dark" @click="updateRouteInRoutes()">Guardar</button>
          </div>
        </div>
      </div>
    </MDBModalFooter>
  </MDBModal>

</template>

<script>
import VueMultiselect from 'vue-multiselect'
import listDriversEnabled from '../../../../modules/users/use-cases/list.drivers.enabled'
import listBusesEnabled from '../../../../modules/buses/use-cases/list.bus.enabled'
import listRoutesEnabled from '../../../../modules/routes/use-cases/list.route.enabled'
import tripValidator from '../../../../kernel/validators/trip.validator'
import getTrip from '../../use-cases/get.trip'
import router from '../../../../router/index'
import updateRoute from '../../use-cases/update.trip';
 import {
    MDBModal,
    MDBModalBody,
    MDBModalHeader,
    MDBModalTitle,
    MDBModalFooter
  } from 'mdb-vue-ui-kit';
import DataTable from 'datatables.net-dt';
import $ from 'jquery';
import Loader from '../../../../components/Loader.vue'
import mapFunctions from '../../../../kernel/map-functions/maps'
import moment from 'moment'

export default {
  name: "UpdateTravel",
  components: {
    VueMultiselect,
    MDBModal,
    MDBModalBody,
    MDBModalHeader,
    MDBModalTitle,
    MDBModalFooter,
    Loader
  },
  data() {
    return {
      showMenu: false,
      activeClass: "js-active position-relative",
      activeStep: 0,
      drivers: [],
      buses: [],
      routes:[],
      days:[
        {value:1, label:"Domingo"},
        {value:2, label:"Lunes"},
        {value:3, label:"Martes"},
        {value:4, label:"Miercoles"},
        {value:5, label:"Jueves"},
        {value:6, label:"Viernes"},
        {value:7, label:"Sábado"},
      ],
      trip:{
        driver:"",
        bus:"",
        ways: [],
        date:"",
        days: "",
      },
      errors:{
        driver:"",
        bus:"",
        route: "",
        date:"",
        day: "",
      },
      idTrip: 0,
      searchedTrip: {},
      tripOriginal: {},
      modal:{
        route: ""
      },
      modalUpdate:{
        route: ""
      },
      newTripModal: false,
      updateTripModal: false,
      routeSelected: null,
      routeSelectedUpdate: null,
      routesSelected: [],
      datatable: null,
      idRouteInUpdate: 0,
      isLoading: false,
    };
  },
  async mounted() {
    this.idTrip = this.$route.params.id;
    this.isLoading = true;
    await this.getTrip(this.idTrip)
    await this.listDriversEnabled()
    await this.listBusesEnabled()
    await this.listRoutesEnabled()
    this.isLoading = false;

  },
  methods: {
     initializaDatatable(){
      if(this.datatable){
        this.datatable.destroy()
      }
      this.$nextTick(()=>{
        this.datatable =  new DataTable('#tableRoutes', {
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
                $('#tableRoutes_previous').addClass('d-none');
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
    async getTrip(id){
      this.isLoading = true;
      const response = {...await getTrip(id)};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.searchedTrip = {...result, 
            driver: {id: result.driver.id, name: `${result.driver.username}`},
            bus: {id: result.bus.id, plaque: result.bus.plaque},
            startTime: new Date(result.startTime).toTimeString().split(' ')[0],
            workDays: JSON.parse(result.workDays).map((day) => ({value: parseInt(day), label: this.getDay(day) }))
          };
          this.searchedTrip.ways.forEach((way) =>{
              this.routesSelected.push({id: way.route.id, name:  way.route.name })
          })
          this.searchedTrip.ways = this.searchedTrip.ways.map((way, index) => ({route: {id: way.route.id}, sequence: index + 1}))
          this.initializaDatatable();
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrió un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
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
    async listDriversEnabled(){
      this.isLoading = true;
      const response = {...await listDriversEnabled()};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.drivers = result.map((item) =>{
            return {id: item.id, name: `${item.username}` }
          })

      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrió un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async listBusesEnabled(){
      this.isLoading = true;
      const response = {...await listBusesEnabled()};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.buses = result.map((bus) =>{{
            return {id: bus.id, plaque: bus.plaque};
          }})
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrió un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async listRoutesEnabled(){
      this.isLoading = true;
      const response = {...await listRoutesEnabled()};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.routes = result;
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrió un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
      async preUpdateTrip(){
      this.initializaDatatable()
      this.errors.bus = tripValidator.validateSelect(this.searchedTrip.bus);
      this.errors.driver = tripValidator.validateSelect(this.searchedTrip.driver);
      this.errors.day = tripValidator.validateMultiSelect(this.searchedTrip.workDays);
      this.errors.date = tripValidator.validateDate(this.searchedTrip.startTime);
      this.errors.ways = tripValidator.validateWays(this.searchedTrip.ways);

      if(!this.errors.bus && !this.errors.driver && !this.errors.day && !this.errors.date && !this.errors.ways){
        const {driver, bus, startTime, workDays, ways} = this.searchedTrip;
        let idRoutes = ways.map((way) => (way.route.id));
        let fullStopovers = [];
        idRoutes.map((id) =>{
            let {stopOvers} = this.routes.find((route) => route.id === id);
            fullStopovers = [...fullStopovers, ...stopOvers]
        })


        let finalStopovers = await Promise.all([...fullStopovers.map(async (stopover, index) =>{
              if(index === 0){
                  stopover.meters = 0
                  stopover.time = 0
              }else{
                stopover.meters = parseFloat(await mapFunctions.getMetersBetweenTwoDirections(fullStopovers[index-1].address.description, fullStopovers[index].address.description));
                stopover.time = parseFloat(await mapFunctions.getTimeBetweenTwoDirections(fullStopovers[index-1].address.description, fullStopovers[index].address.description));
              }
              stopover.sequence = index + 1;
              return stopover;
        })])

        let meters = 0;
        let time = 0;
        finalStopovers.forEach((stopover) => {
          meters += stopover.meters;
          time += stopover.time;
        });

        let jsonStopover = JSON.stringify(finalStopovers);

        let date = new Date().toISOString().split('T')[0];
        let finalDate = `${date} ${startTime}`
        console.log(finalDate);
        const tripPayload = {
          id: this.searchedTrip.id,
          driver: {id: driver.id},
          bus: {id: bus.id},
          startTime:  moment(finalDate).format('YYYY-MM-DDTHH:mm:ss'),
          workDays: JSON.stringify(workDays.map((day) => (day.value.toString()))),
          ways: ways,
          stopovers: jsonStopover,
          meters,
          time
        }
        this.$swal({
          title: "¿Estás seguro(a) de guardar los cambios?",
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
              const {message, error, data} = await updateRoute(tripPayload)
              this.isLoading = false;
              if(!error){
                const {result:{text}} = data
                this.$swal({
                  icon: "success",
                  title: message,
                  text: text,
                  type: 'success-message',
                });
                router.push({name: 'Consultar Viajes'})
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
    cancelar(){
       router.push({name: 'Consultar Viajes'})
    },
    getDay(value){
      const {label} = this.days.find(day => day.value === parseInt(value))
      return label;
    },
    removeRoute(id){
      this.routesSelected = [...this.routesSelected.filter(route => route.id !== id)]
      if(this.routesSelected.length > 0){
        this.routesSelected = [...this.routesSelected.map((route, index)=>{
        route.sequence = index+1;
        return route;
        })]
      }

       this.searchedTrip.ways = [...this.searchedTrip.ways.filter(way => way.route.id !== id)]
      if(this.searchedTrip.ways.length > 0){
        this.searchedTrip.ways = [...this.searchedTrip.ways.map((way, index)=>{
        way.sequence = index+1;
        return way;
        })]
      }
      this.initializaDatatable()
     
    },
      addRoute(){
      this.modal.route = tripValidator.validateSelect(this.routeSelected);
      if(!this.modal.route){
        let isThereRoute;
        if(this.searchedTrip.ways.length > 0){
           isThereRoute = this.searchedTrip.ways.find((way) => way.route.id === this.routeSelected.id);
        }

        if(!isThereRoute){
          this.searchedTrip.ways.push({route:{id: this.routeSelected.id}, sequence: (this.searchedTrip.ways.length + 1)})
          this.routesSelected.push({id: this.routeSelected.id, name:  this.routeSelected.name })
          this.initializaDatatable();
          this.closeModalNewTrip()
        }else{
           this.$swal({
            icon: "info", 
            title: 'La ruta ya se ha agregado',
            type: "basic",
          });
        }
        
      }
    },
     updateRouteInRoutes(){
      this.modalUpdate.route = tripValidator.validateSelect(this.routeSelectedUpdate);
      if(!this.modalUpdate.route){
        let isThereRoute;
        if(this.searchedTrip.ways.length > 0){
           isThereRoute = this.searchedTrip.ways.find((way) => way.route.id === this.routeSelectedUpdate.id);
        }

        if(!isThereRoute){
          this.searchedTrip.ways = [... this.searchedTrip.ways.map((way) =>{
              if(way.route.id === this.idRouteInUpdate){
                way = {...way, route:{id: this.routeSelectedUpdate.id}};
              }
              return way;
           })]

          this.routesSelected = [... this.routesSelected.map((route) =>{
              if(route.id === this.idRouteInUpdate){
                route = {...route, id: this.routeSelectedUpdate.id, name: this.routeSelectedUpdate.name};
              }
              return route;
           })]
          this.initializaDatatable();
          this.closeModalUpdateTrip()
        }else{
           this.$swal({
            icon: "info", 
            title: 'La ruta ya se ha agregado',
            type: "basic",
          });
        }
        
      }
    },
    updateRoute(id){
      this.idRouteInUpdate = id;
      this.routeSelectedUpdate = this.routes.find((route) => route.id === id);
      this.updateTripModal = true;
    },
    openModalNewRoute(){
      this.newTripModal = true;
    },
    closeModalNewTrip(){
      this.modal.route = ""
      this.routeSelected = null;
      this.newTripModal = false;
    },
    closeModalUpdateTrip(){
      this.modalUpdate.route = ""
      this.routeSelectedUpdate = null;
      this.updateTripModal = false;
    }
    
  },
};
</script>
<style src="vue-multiselect/dist/vue-multiselect.css"></style>
<style>
.isInvalid{
    border-radius: 5px !important;
    border: 1px solid #fd5c70 !important;
}
.isValid{
    border-radius: 5px !important;
    border: 1px solid #66d432 !important;
}
</style>  