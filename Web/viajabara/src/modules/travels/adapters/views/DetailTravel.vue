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
                  <input
                    :value="searchedTrip.driver?.name"
                    class="form-control"
                    disabled
                    >
            </div>
            <div class="col-12 col-lg-6 mb-3">
              <label>Unidad(<span class="text-danger">*</span>)</label>
                <input
                    :value="searchedTrip.bus?.plaque"
                    class="form-control"
                    disabled
                    />
            </div>

            <div class="col-12 col-lg-6 mb-3">
              <label>Hora(<span class="text-danger">*</span>)</label>
              <input type="time" class="form-control" id="date" name="date" :value="searchedTrip?.startTime" disabled>
            </div>


              <div class="col-12 col-lg-6 mb-3">
              <label>Días(<span class="text-danger">*</span>)</label>
               <VueMultiselect
                    v-model="searchedTrip.workDays"
                    :options="days" 
                    :multiple="true" 
                    :disabled="true"
                    label="label" 
                    track-by="value" 
                    :preselect-first="false"
                    >
                     <template #noResult>
                      Elemento no encontrado.
                    </template>
                  </VueMultiselect>
                <div v-if="errors.day" style="color: red">
                    {{ errors.day }}
              </div>
            </div>

              <div class="col-12 mt-3">
                <h6>Detalles de la ruta</h6>
              </div>
              <hr class="my-3 horizontal dark" />
              <div class="col-12 ">
               <GMapMap
              :center="center"
              ref="myMapRef"
              :zoom="zoom"
              style="height: 40rem"
               :options="mapOptions" 
               >
              </GMapMap>
              </div>


          </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">
                <button type="button" class="btn btn bg-gradient-dark mb-0 ms-auto js-btn-next" @click="cancelar()" title="Regresar">Regresar</button>
            </div>
          </div>
      </div>
    </div>
  </div>
  </div>
</template>

<script>
import VueMultiselect from 'vue-multiselect'
import listDriversEnabled from '../../../../modules/users/use-cases/list.drivers.enabled'
import listBusesEnabled from '../../../../modules/buses/use-cases/list.bus.enabled'
import listRoutesEnabled from '../../../../modules/routes/use-cases/list.route.enabled'
import getTrip from '../../use-cases/get.trip'
import router from '../../../../router/index'
import mapFunctions from '../../../../kernel/map-functions/maps'
import Loader from '../../../../components/Loader.vue'

export default {
  name: "DetailTravel",
  components: {
    VueMultiselect,
    Loader
  },
  data() {
    return {
      showMenu: false,
      activeClass: "js-active position-relative",
      activeStep: 0,
      formSteps: 3,
      selected: null,
      options: ['list', 'of', 'options'],
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
        route: "",
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
      zoom: 12,
      center: {lat:23.634501, lng: -102.552784},
      mapOptions: {
        disableDefaultUI: true, 
      },
      map:{},
      isLoading:false,
    };
  },
  async mounted() {
    this.idTrip = this.$route.params.id;
    this.isLoading = true;
    await this.getTrip(this.idTrip)
    await this.listDriversEnabled()
    await this.listBusesEnabled()
    await this.listRoutesEnabled()
    await this.getRouteWithPaths()
    this.isLoading = false;

  },
  methods: {
    async getTrip(id){
      const response = {...await getTrip(id)};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.searchedTrip = {...result, 
            driver: {id: result.driver.id, name: result.driver.username},
            bus: {id: result.bus.id, plaque: result.bus.plaque},
            startTime: new Date(result.startTime).toTimeString().split(' ')[0],
            workDays: JSON.parse(result.workDays).map((day) => ({value: parseInt(day), label: this.getDay(day) }))
          };
          this.tripOriginal =  {...result, driver: {id: result.driver.id, name: `${result.driver.person.name} ${result.driver.person.surname}` }};
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
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
      const response = {...await listDriversEnabled()};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.drivers = result.map((item) =>{
            return {id: item.id, name: `${item.person.name} ${item.person.surname}` }
          })

      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async listBusesEnabled(){
      const response = {...await listBusesEnabled()};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.buses = result.map((bus) =>{{
            return {id: bus.id, plaque: bus.plaque};
          }})
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async listRoutesEnabled(){
      const response = {...await listRoutesEnabled()};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.routes = result
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
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
    async getRouteWithPaths(){
      
      this.$refs.myMapRef.$mapPromise.then(async (mapObject) => {
        let stopovers = JSON.parse(this.searchedTrip.stopovers)


          const waypoints = stopovers.map((stopover) => {
            if (stopover.sequence !== 1 && stopover.sequence !== stopovers.length) {
              return {location: stopover.address.description, stopover: true };
            }
            return undefined;
          }).filter(element => element !== undefined);

        const response = await mapFunctions.getRouteWithPaths(waypoints, stopovers[0].address.description, stopovers[(stopovers.length -1)].address.description);
        let directionsRenderer = new window.google.maps.DirectionsRenderer();
        directionsRenderer.setMap(mapObject);
        directionsRenderer.setDirections(response);
      });
    },
    
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