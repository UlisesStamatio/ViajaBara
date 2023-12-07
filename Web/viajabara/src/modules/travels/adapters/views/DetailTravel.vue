<template>
  <div class="container-fluid">
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
              <label>Ruta(<span class="text-danger">*</span>)</label>
              <input
                    :value="searchedTrip.route?.name"
                    class="form-control"
                    disabled/>
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


          </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">
                <button type="button" class="btn btn bg-gradient-dark mb-0 me-2 ms-auto js-btn-next" @click="cancelar()" title="Regresar">Regresar</button>
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

export default {
  name: "DetailTravel",
  components: {
    VueMultiselect,
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
      tripOriginal: {}
    };
  },
  async mounted() {
    this.idTrip = this.$route.params.id;
    await this.getTrip(this.idTrip)
    await this.listDriversEnabled()
    await this.listBusesEnabled()
    await this.listRoutesEnabled()

  },
  methods: {
    async getTrip(id){
      this.isLoading = true;
      const response = {...await getTrip(id)};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.searchedTrip = {...result, 
            driver: {id: result.driver.id, name: `${result.driver.person.name} ${result.driver.person.surname}`},
            bus: {id: result.bus.id, plaque: result.bus.plaque},
            route: {id: result.route.id, name: `${result.route.endAddress.description.split(',')[0]} - ${result.route.startAddress.description.split(',')[0]}`},
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
      this.isLoading = true;
      const response = {...await listDriversEnabled()};
      const {error, data} = response;
      this.isLoading = false;
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
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
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
          this.routes = result.map((route) =>{
            return {id: route.id, name: `${route.endAddress.description.split(',')[0]} - ${route.startAddress.description.split(',')[0]}`}
          })
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