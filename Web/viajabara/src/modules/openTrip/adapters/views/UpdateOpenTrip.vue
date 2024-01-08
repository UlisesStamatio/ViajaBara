<template>
    <Loader :isLoading="isLoading"/>
      <div class="container-fluid" v-show="!isLoading">
        <form class="row g-3" @submit.prevent="preUpdateOpenTrip">
             <div class="mt-4 col-12 card card-body">
                <div class="row">
                    <div class="col-12">
                        <h6 class="mb-0">Información de la apertura</h6>
                        <hr class="mt-3 horizontal dark" />    
                    </div> 
                    <div class="col-12 col-lg-6  mt-3">
                        <label>Viaje(<span class="text-danger">*</span>)</label>
                        <VueMultiselect
                            v-model="openTrip.trip"
                            :options="viajes"
                            selectLabel="Presiona para seleccionar"
                            selectedLabel="Seleccionado"
                            deselectLabel="Presiona para remover"
                            placeholder="Buscar.."
                            label="name"
                            track-by="name" 
                            :class="{'isInvalid': errors.trip, 'isValid': errors.trip === null}"
                            >
                            <template #noResult>
                            Elemento no encontrado.
                            </template>
                        </VueMultiselect>
                        <div v-if="errors.trip" style="color: red">
                                {{ errors.trip }}
                        </div>
                    </div>
                    <div class="col-12 col-lg-6 mt-3">
                        <label>No. semanas de disponibilidad(<span class="text-danger">*</span>)</label>
                        <input type="number" v-model="openTrip.weekNumber" class="form-control" placeholder="eg. 2" id="weekNumber" :class="{ 'is-invalid': errors.weekNumber, 'is-valid': errors.weekNumber === null }">
                        <div v-if="errors.weekNumber" style="color: red">
                                {{ errors.weekNumber }}
                        </div>
                    </div>

                    <div class="col-12 text-end mt-4">
                         <button type="button" class="btn bg-gradient-secondary mb-0 me-2 ms-auto js-btn-next" title="Cancelar">Cancelar</button>
                         <button type="submit" class="btn bg-gradient-dark mb-0 ms-auto js-btn-next" title="Crear Apertura" >Crear Apertura</button>
                    </div>   
                </div>  
             </div>
        </form>
      </div>
</template>

<script>
//import router from '../../../../router/index'
import Loader from '../../../../components/Loader.vue'
import VueMultiselect from 'vue-multiselect'
import listTripsUnopened from '../../../../modules/travels/use-cases/list.trips.unopened'
import openTrip from '../../../../modules/openTrip/use-cases/open.trip'
//import moment from 'moment'
import openTripValidator from '../../../../kernel/validators/opentrip.validator'
import router from '../../../../router/index'

export default {
  name: "NewUser",
  components:{
    Loader,
    VueMultiselect
  },
  data(){
    return{
        isLoading: false,
        openTrip:{
            trip: "",
            weekNumber: "",
        },
        errors:{
            trip: "",
            weekNumber: "",
        },
        viajes: [],
    }
  },
  async mounted(){
    await this.listTripsUnopened()
  },
  methods:{
    async listTripsUnopened(){
      const response = {...await listTripsUnopened()};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.viajes = result;
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrió un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async preUpdateOpenTrip(){
      console.log(this.openTrip.trip);
      this.errors.weekNumber = openTripValidator.validateNumberWeeks(this.openTrip.weekNumber);
      this.errors.trip = openTripValidator.validateSelect(this.openTrip.trip);

      if(!this.errors.weekNumber && !this.errors.trip){
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
            console.log("Hola");
            let payload = {
              idTrip: this.openTrip.trip.id,
              numberWeeks: this.openTrip.weekNumber
            }
              this.isLoading = true;
              const {message, error, data} = await openTrip(payload)
              this.isLoading = false;
              if(!error){
                const {result:{text}} = data
                this.$swal({
                  icon: "success",
                  title: message,
                  text: text,
                  type: 'success-message',
                });
                router.push({name: 'Consultar Aperturas'})
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
  }
}
</script>