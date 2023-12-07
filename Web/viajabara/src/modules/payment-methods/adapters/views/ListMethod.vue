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
                <h5 class="mb-0">Lista de métodos</h5>
              </div>
              <div class="my-auto mt-4 ms-auto mt-lg-0">
                <div class="my-auto ms-auto">
                  <router-link
                    :to="{ name: 'Registrar Método' }"
                    class="mb-0 btn bg-gradient-danger btn-sm"
                    >+&nbsp; Nuevo Método</router-link
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body mx-4 my-3">
            <div class="table-responsive">
              <table id="methods-list" class="table table-flush">
                <thead class="thead-light">
                  <tr>
                    <th style="font-size: 0.65em; font-weight: bold; text-align: start">#</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Nombre</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Estatus</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Acciones</th>
                  </tr>
                </thead>
                 <tbody>
                  <tr v-for="({name, status, id}, index) in methods" :key="index">
                    <td>{{(index + 1)}} </td>
                    <td class="text-sm" >{{name}}</td>
                    <td class="text-center">
                      <span class="badge badge-success badge-sm" :class="{'badge-success': status, 'badge-danger': !status}"
                        >{{status ? 'Activo' : 'Inactivo'}}</span
                      >
                    </td>
                    <td class="text-sm">
                      <a
                        title="Actualizar método"
                        @click="updateMethod(id)"
                        class="clickeable"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                      
                        <a
                        title="Visualizar método"
                        @click="detailMethod(id)"
                        class="mx-3 clickeable"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        title="Desactivar método"
                        @click="changeStatusMethod(id, name)"
                        class="clickeable"
                        v-if="status"
                      >
                        <i class="fa fa-times-circle text-secondary" ></i>
                      </a>
                        <a
                        title="Activar método"
                        @click="changeStatusMethod(id, name)"
                        class="clickeable"
                        v-if="!status"
                        >
                        <i class="fa fa-check-circle text-secondary" ></i>
                      </a>
                    </td>
                  </tr>

                </tbody>
                 <tfoot>
                  
                </tfoot>
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
import listMethods from '../../use-cases/list.methods'
import changeStatusMethod from '../../use-cases/change.status.method'
import Loader from '../../../../components/Loader.vue'
import $ from 'jquery';
import router from '../../../../router/index'

export default {
  name: "ListMethod",
  components:{
    Loader,
  },
  data(){
    return{
      methods: [],
      isLoading: false,
      datatable: null,
    }
  },
  async mounted() {
    await this.datatableMethods()
    setTooltip(this.$store.state.bootstrap);
  },
  methods:{
    async listMethods(){
      this.isLoading = true;
      const response = {...await listMethods()};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.methods = result
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consulta. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async datatableMethods(){
        await this.listMethods();
       if(this.datatable){
            this.datatable.destroy()
          }
          this.$nextTick(()=>{
            this.datatable =  new DataTable('#methods-list', {
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
                  $('#methods-list_previous').addClass('d-none');
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
    async changeStatusMethod(id, name){
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
                const response = {...await changeStatusMethod(id)};
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
                    await this.datatableMethods()
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
    updateMethod(id){
      router.push({name: 'Modificar Método', params: {id: id}})
    },
    detailMethod(id){
      router.push({name: 'Visualizar Método', params: {id: id}})
    }
  }
};
</script>
<style scoped>
  .clickeable{
    cursor: pointer;
  }
</style>
