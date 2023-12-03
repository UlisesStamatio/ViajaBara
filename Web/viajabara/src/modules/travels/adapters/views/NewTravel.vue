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
                  <VueMultiselect
                    
                    v-model="trip.driver"
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
                    v-model="trip.bus"
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
              <label>Ruta(<span class="text-danger">*</span>)</label>
              <VueMultiselect
                    v-model="trip.route"
                    :options="routes"
                    selectLabel="Presiona para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presiona para remover"
                    placeholder="Buscar.."
                    label="name"
                    :class="{'isInvalid': errors.route, 'isValid': errors.route === null}"
                    >
                     <template #noResult>
                      Elemento no encontrado.
                    </template>
                  </VueMultiselect>
               <div v-if="errors.route" style="color: red">
                    {{ errors.route }}
              </div>
            </div>

            <div class="col-12 col-lg-6 mb-3">
              <label>Hora(<span class="text-danger">*</span>)</label>
              <input type="time" class="form-control" id="date" name="date" v-model="trip.date" :class="{ 'is-invalid': errors.date, 'is-valid': errors.date === null }">
              <div v-if="errors.date" style="color: red">
                    {{ errors.date }}
              </div>
            </div>


              <div class="col-12 col-lg-6 mb-3">
              <label>Días(<span class="text-danger">*</span>)</label>
               <VueMultiselect
                    v-model="trip.days" 
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


          </div>
          <div class="row mt-4">
            <div class="col-12 text-end ">
                <button type="button" class="btn bg-gradient-secondary mb-0 me-2 ms-auto js-btn-next" @click="cancelar()" title="Cancelar">Cancelar</button>
                <button type="button" class="btn bg-gradient-dark mb-0 ms-auto js-btn-next" title="Crear Viaje" @click="preNewTrip()">Crear Viaje</button>
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
import tripValidator from '../../../../kernel/validators/trip.validator'
import newTrip from '../../use-cases/new.trip'
import router from '../../../../router/index'
export default {
  name: "NewUser",
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
      }
    };
  },
  async mounted() {
    await this.listDriversEnabled()
    await this.listBusesEnabled()
    await this.listRoutesEnabled()

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
    preNewTrip(){

      this.errors.bus = tripValidator.validateSelect(this.trip.bus);
      this.errors.driver = tripValidator.validateSelect(this.trip.driver);
      this.errors.route = tripValidator.validateSelect(this.trip.route);
      this.errors.day = tripValidator.validateMultiSelect(this.trip.days);
      this.errors.date = tripValidator.validateDate(this.trip.date);

        if(!this.errors.bus && !this.errors.driver && !this.errors.route && !this.errors.day && !this.errors.date){
        const {driver, bus, date, days, route} = this.trip;
        const today = new Date();
        const hour = date.split(':');
        today.setHours(parseInt(hour[0])-6, parseInt(hour[1]), 0, 0);
        const tripPayload = {
          driver: {id: driver.id},
          bus: {id: bus.id},
          startTime: today.toISOString(),
          workDays: JSON.stringify(days.map((day) => (day.value.toString()))),
          route: {id: route.id}
        }
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
              const {message, error, data} = await newTrip(tripPayload)
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