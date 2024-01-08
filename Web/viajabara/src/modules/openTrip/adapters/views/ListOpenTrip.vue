<template>
<Loader :isLoading="isLoading"/>
  <div class="py-4 container-fluid" v-show="!isLoading">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <!-- Card header -->
          <div class="pb-0 card-header">
            <div class="d-lg-flex">
              <div>
                <h5 class="mb-0">Lista de aperturas</h5>
              </div>
              <div class="my-auto mt-4 ms-auto mt-lg-0">
                <div class="my-auto ms-auto">
                  <router-link
                    :to="{ name: 'Registrar Apertura' }"
                    class="mb-0 btn bg-gradient-danger btn-sm"
                    >+&nbsp; Nuevo Apertura</router-link
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body mx-4 my-4">
            <div class="table-responsive">
              <table id="products-list" class="table table-flush">
                <thead class="thead-light">
                  <tr>
                    <th style="font-size: 0.65em; font-weight: bold; text-align: start">#</th>
                    <th style="font-size: 0.65em; font-weight: bold">Sobrenombre</th>
                    <th style="font-size: 0.65em; font-weight: bold">Fecha Inicio</th>
                    <th style="font-size: 0.65em; font-weight: bold">Fecha Fin</th>
                    <th style="font-size: 0.65em; font-weight: bold">Número de semanas</th>
                    <th style="font-size: 0.65em; font-weight: bold">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(trip, index) in trips" :key="index">
                    <td class="text-center">
                      {{index + 1}}
                    </td> 
                    <td class="text-sm">{{trip.name}}</td>
                    <td class="text-sm text-center">{{trip.repeatStartDate}}</td>
                    <td class="text-sm text-center">{{trip.repeatEndDate}}</td>
                    <td class="text-sm text-center">{{trip.numberWeeks}}</td>

                    <td class="text-sm text-center">
                         <a
                            title="Actualizar viaje"
                            class="clickeable"
                            @click="editTrip(trip.id)"
                          >
                            <i class="fa fa-pencil-square-o text-secondary"></i>
                          </a>
                          <a
                          title="Visualizar viaje"
                            class="mx-2 clickeable"
                            @click="detailTrip(trip.id)"
                          >
                            <i class="fas fa-eye text-secondary"></i>
                          </a>
                      
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import setTooltip from "@/assets/js/tooltip.js";
import DataTable from 'datatables.net-dt';
import $ from 'jquery';
import listTripsOpened from '../../../../modules/travels/use-cases/list.trips.opened'
import changeStatusTrip from '../../../travels/use-cases/change.status.trip';
//import router from '../../../../router/index'
import Loader from '../../../../components/Loader.vue'
import moment from 'moment'

export default {
  name: "ListTravel",
  components:{
    Loader,
  },
  data(){
    return {
      trips: [],
      datatable: null,
      isLoading: false,
    }
  },
  async mounted() {
    await this.initializaDatatable()
    setTooltip(this.$store.state.bootstrap);
  },
  methods:{
    async initializaDatatable(){
      try{
        this.isLoading = true;
         const {data:{result} } = await listTripsOpened();
         this.trips = result.map((trip) => {
            return {...trip, repeatEndDate: moment(trip.repeatEndDate).format('DD-MM-YYYY HH:mm'), repeatStartDate: moment(trip.repeatStartDate).format('DD-MM-YYYY HH:mm')}
            })
         console.log(this.trips);
         if(this.datatable){
          this.datatable.destroy()
         }
        this.$nextTick(()=>{
         this.datatable =  new DataTable('#products-list', {
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
                $('#products-list_previous').addClass('d-none');
          },
          columnDefs: [
                {
                    targets: [0, 1, 2], // Índices de las columnas que deben ser visibles
                    visible: true
                }
          ]
          });
        })
        this.isLoading = false;
      }catch(err){
         this.isLoading = false;
        this.$swal({icon: "error", title: err, type: "basic" });
      }
    },
    async changeStatusTrip(payload){
      this.$swal({
            title: "¿Estás seguro(a) de cambiar el estatus del viaje?",
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
                const response = {...await changeStatusTrip(payload)};
                const {error, data, message} = response;
                this.isLoading = false;
                if(!error){
                    const {result:{text}} =data
                    this.$swal({
                      icon: "success",
                      title: message,
                      text: text,
                      type: 'success-message',
                    });
                   await this.initializaDatatable()
                }else{
                  const {text} = data;
                    this.$swal({
                      icon: "error", 
                      title: text,
                      type: "basic",
                  });
                }
            } else if (result.dismiss === this.$swal.DismissReason.cancel) {
              this.$swal.dismiss;
            }
          })
    },
  }
};
</script>

<style scoped>
  .clickeable{
    cursor: pointer;
  }
</style>