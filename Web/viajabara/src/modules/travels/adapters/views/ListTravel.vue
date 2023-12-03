<template>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <!-- Card header -->
          <div class="pb-0 card-header">
            <div class="d-lg-flex">
              <div>
                <h5 class="mb-0">Lista de viajes</h5>
              </div>
              <div class="my-auto mt-4 ms-auto mt-lg-0">
                <div class="my-auto ms-auto">
                  <router-link
                    :to="{ name: 'Registro Viaje' }"
                    class="mb-0 btn bg-gradient-primary btn-sm"
                    >+&nbsp; Nuevo Viaje</router-link
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
                    <th style="font-size: 0.65em; font-weight: bold">Conductor</th>
                    <th style="font-size: 0.65em; font-weight: bold">Autobus</th>
                    <th style="font-size: 0.65em; font-weight: bold">Ruta</th>
                    <th style="font-size: 0.65em; font-weight: bold">Hora</th>
                    <th style="font-size: 0.65em; font-weight: bold">Estatus</th>
                    <th style="font-size: 0.65em; font-weight: bold">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="(trip, index) in trips" :key="index">
                    <td class="text-center">
                      {{index + 1}}
                    </td> 
                    <td class="text-sm">{{trip.driver.person.name + ' ' + trip.driver.person.surname}}</td>
                    <td class="text-sm">{{trip.bus.serial}}</td>
                    <td class="text-sm">{{trip.route}}</td>
                    <td class="text-sm">{{trip.startTime}}</td>
                    <td>
                       <span class="badge badge-sm" :class="{'badge-success': trip.status, 'badge-danger': !trip.status}"
                          >{{trip.status ? 'Activo' : 'Inactivo'}}</span
                        >
                    </td>
                    <td class="text-sm">
                         <a
                            class="clickeable"
                            data-bs-toggle="tooltip"
                            data-bs-original-title="Modificar viaje"
                            @click="editTrip(trip.id)"
                          >
                            <i class="fa fa-pencil-square-o text-secondary"></i>
                          </a>
                          <a
                            class="mx-2 clickeable"
                            data-bs-toggle="tooltip"
                            data-bs-original-title="Visualizar viaje"
                            @click="detailTrip(trip.id)"
                          >
                            <i class="fas fa-eye text-secondary"></i>
                          </a>
                          <a
                          class="clickeable"
                          data-bs-toggle="tooltip"
                          data-bs-original-title="Desactivar viaje"
                          v-show="trip.status"
                          @click="changeStatusTrip({id: trip.id})"
                        >
                          <i class="fa fa-times-circle text-secondary" ></i>
                        </a>
                          <a
                          class="clickeable"
                          data-bs-toggle="tooltip"
                          data-bs-original-title="Activar viaje"
                          v-show="!trip.status"
                          @click="changeStatusTrip({id: trip.id})"
                          >
                          <i class="fa fa-check-circle text-secondary" ></i>
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
import listTrips from '../../use-cases/list.trips';
import changeStatusTrip from '../../use-cases/change.status.trip';

export default {
  name: "ListTravel",
  data(){
    return {
      trips: [],
      datatable: null,
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
         const {data:{result} } = await listTrips();
         this.trips = result.map((trip) =>{
          trip.route.startAddress.description.split(',')[0] + ' - ' + trip.route.endAddress.description.split(',')[0]
          return {...trip, route: trip.route.startAddress.description.split(',')[0] + ' - ' + trip.route.endAddress.description.split(',')[0], startTime: new Date(trip.startTime).toISOString().split('T')[1].split('.')[0]}
         })
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
            title: "¿Estás segura(a) de realizar la acción?",
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
    }
  }
};
</script>

<style scoped>
  .clickeable{
    cursor: pointer;
  }
</style>