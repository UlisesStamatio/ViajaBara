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
                <h5 class="mb-0">Lista de rutas</h5>
              </div>
              <div class="my-auto mt-4 ms-auto mt-lg-0">
                <div class="my-auto ms-auto">
                  <router-link
                    :to="{ name: 'Registrar Ruta' }"
                    class="mb-0 btn bg-gradient-danger btn-sm"
                    >+&nbsp; Nueva ruta</router-link
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
                    <th style="font-size: 0.65em; font-weight: bold">Nombre</th>
                    <th style="font-size: 0.65em; font-weight: bold">No. de paradas</th>
                    <th style="font-size: 0.65em; font-weight: bold">Estatus</th>
                    <th style="font-size: 0.65em; font-weight: bold">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <tr  v-for="(route, index) in routes" :key="index">
                      <td class="text-center">{{index + 1}}</td>
                      <td>{{route.name}}</td> 
                      <td class="text-center">{{route.stopOvers.length}}</td> 
                      <td class="text-center">
                        <span class="badge badge-sm" :class="{'badge-success': route.status, 'badge-danger': !route.status}"
                          >{{route.status ? 'Activo' : 'Inactivo'}}</span
                        >
                      </td>
                      <td class="text-sm">
                           <a
                            class="clickeable"
                            title="Actualizar ruta"
                            @click="editRoute(route.id)"
                          >
                            <i class="fa fa-pencil-square-o text-secondary"></i>
                          </a>
                          <a
                            title="Visualizar ruta"
                            class="mx-3 clickeable"
                            @click="detailRoute(route.id)"
                          >
                            <i class="fas fa-eye text-secondary"></i>
                          </a>
                          <a
                          class="clickeable"
                          title="Desactivar ruta"
                          v-show="route.status"
                          @click="changeStatusRoute({id: route.id}, route.name)"
                        >
                          <i class="fa fa-times-circle text-secondary" ></i>
                        </a>
                          <a
                          class="clickeable"
                          title="Activar ruta"
                          v-show="!route.status"
                          @click="changeStatusRoute({id: route.id}, route.name)"
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
//import { DataTable } from "simple-datatables";
import setTooltip from "@/assets/js/tooltip.js";
import listRoutes from '../../use-cases/list.route'
import changeStatusRoute from '../../use-cases/change.status.route';
import DataTable from 'datatables.net-dt';
import $ from 'jquery';
import Loader from '../../../../components/Loader.vue'
import router from '../../../../router/index'


export default {
  name: "ListRoute",
  components:{
    Loader,
  },
  data(){
    return{
      routes:[],
      datatable: null,
      isLoading: false
    }
  },
  mounted() {
    this.initializaDatatable()
    setTooltip(this.$store.state.bootstrap);
  },
  methods:{
    async initializaDatatable(){
      try{
        this.isLoading = true;
         const {data:{result} } = await listRoutes();
         this.routes = result
         
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
    editRoute(id){
      router.push({name: 'Modificar Ruta', params: {id: id}})
    },
    detailRoute(id){
      router.push({name: 'Visualizar Ruta', params: {id: id}})
    },
    async changeStatusRoute(payload, name){
      this.$swal({
            title: `¿Estás segura(a) de cambiar el estatus de <strong>${name}</strong>?`,
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
                const response = {...await changeStatusRoute(payload)};
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
