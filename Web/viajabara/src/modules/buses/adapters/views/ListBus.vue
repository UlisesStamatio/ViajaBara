<template>
<Loader :isLoading="isLoading"/>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <!-- Card header -->
          <div class="pb-0 card-header">
            <div class="d-lg-flex">
              <div>
                <h5 class="mb-0">Lista de unidades</h5>
              </div>
              <div class="my-auto mt-4 ms-auto mt-lg-0">
                <div class="my-auto ms-auto">
                  <router-link
                    :to="{ name: 'Registrar Unidad' }"
                    class="mb-0 btn bg-gradient-danger btn-sm"
                    >+&nbsp; Nueva unidad</router-link
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body mx-4 my-3">
            <div class="table-responsive">
              <table id="units-list" class="table table-flush">
                <thead class="thead-light">
                  <tr>
                    <th style="font-size: 0.65em; font-weight: bold; text-align: start">#</th>
                    <th style="font-size: 0.65em; font-weight: bold">Placa</th>
                    <th style="font-size: 0.65em; font-weight: bold">Marca</th>
                    <th style="font-size: 0.65em; font-weight: bold">Modelo</th>
                    <th style="font-size: 0.65em; font-weight: bold">Estatus</th>
                    <th style="font-size: 0.65em; font-weight: bold">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="({plaque, mark, model, status, id}, index) in buses" :key="index">
                    <td>
                      {{index + 1}}
                    </td>
                    <td class="text-sm">{{plaque}}</td>
                    <td class="text-sm">{{mark}}</td>
                    <td class="text-sm">{{model}}</td>
                    <td>
                       <span class="badge  badge-sm" :class="{'badge-success': status, 'badge-danger': !status}"
                        >{{status ? 'Activo' : 'Inactivo'}}</span
                      >
                    </td>
                    <td class="text-sm">

                      <a
                        title="Actualizar unidad"
                        @click="updateUnit(id)"
                        class="clickeable"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                      
                        <a
                        title="Visualizar unidad"
                        @click="detailUnit(id)"
                        class="mx-3 clickeable"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        title="Desactivar unidad"
                        @click="changeStatusUnit(id, plaque)"
                        class="clickeable"
                        v-if="status"
                      >
                        <i class="fa fa-times-circle text-secondary" ></i>
                      </a>
                        <a
                        title="Activar unidad"
                        @click="changeStatusUnit(id, plaque)"
                        class="clickeable"
                        v-if="!status"
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
import DataTable from 'datatables.net-dt';
import setTooltip from "@/assets/js/tooltip.js";
import listBuses from '../../use-cases/list.bus'
import changeStatusBus from '../../use-cases/change.status.bus'
import Loader from '../../../../components/Loader.vue'
import $ from 'jquery';
import router from '../../../../router/index'

export default {
  name: "ListBus",
  components:{
    Loader,
  },
  data(){
    return{
      buses: [],
      datatable: null,
      isLoading: false,
    }
  },
  async mounted() {
    await this.datatableBuses();
    setTooltip(this.$store.state.bootstrap);
  },
  methods:{
    async listBuses(){
      this.isLoading = true;
      const response = {...await listBuses()};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.buses = result
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async datatableBuses(){
        await this.listBuses()
        if(this.datatable){
            this.datatable.destroy()
          }
          this.$nextTick(()=>{
            this.datatable =  new DataTable('#units-list', {
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
                  $('#units-list_previous').addClass('d-none');
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
    async changeStatusUnit(id, plaque){
       this.$swal({
            title: `¿Estás segura(a) de cambiar el estatus <strong>${plaque}</strong>?`,
            icon: "warning",
            type: "custom-html",
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
                const response = {...await changeStatusBus(id)};
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
                    await this.datatableBuses()
                }else{
                    this.$swal({
                      icon: "error", 
                      title: 'Ocurrio un error durante la actualización. Inténtalo de nuevo.',
                      type: "basic",
                  });
                }
            } else if (result.dismiss === this.$swal.DismissReason.cancel) {
              this.$swal.dismiss;
            }
          })
    },
    eventListeners(){
          let elementos = document.querySelectorAll('[id*="times"]');
          const method = this.changeStatus;

          elementos.forEach(function(elemento) {
              elemento.addEventListener('click', async function() {
                  const id = elemento.id.toString().split('-')[1]
                  await method(id)
              });
          });
    },
    detailUnit(id){
      router.push({name: 'Visualizar Unidad', params: {id: id}})
    },
    updateUnit(id){
      router.push({name: 'Modificar Unidad', params: {id: id}})
    }
  }
};
</script>


<style scoped>
  .clickeable{
    cursor: pointer;
  }
</style>
