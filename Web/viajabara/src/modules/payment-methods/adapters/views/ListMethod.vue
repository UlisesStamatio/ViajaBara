<template>
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
                    :to="{ name: 'Registro Método' }"
                    class="mb-0 btn bg-gradient-primary btn-sm"
                    >+&nbsp; Nuevo Método</router-link
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body">
            <div class="table-responsive">
              <table id="methods-list" class="table table-flush">
                <thead class="thead-light">
                  <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Estatus</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                 <tbody v-if="methods.length !== 0">
                  <tr v-for="({name, status, id}, index) in methods" :key="index">
                    <td>{{(index + 1)}} </td>
                    <td class="text-sm" >{{name}}</td>
                    <td>
                      <span class="badge badge-success badge-sm" :class="{'badge-success': status, 'badge-danger': !status}"
                        >{{status ? 'Activo' : 'Inactivo'}}</span
                      >
                    </td>
                    <td class="text-sm">

                      <router-link
                        :to="{ name: 'Modificar Método', params:{id:id} }"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Editar método"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </router-link>
                        <router-link
                          :to="{ name: 'Detalles Método', params:{id:id} }"
                          class="mx-3"
                          data-bs-toggle="tooltip"
                          data-bs-original-title="Detalles del método"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </router-link>
                       <a
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Desactivar método"
                        v-if="status"
                        :id="'times-'+id"
                      >
                        <i class="fa fa-times-circle text-secondary"></i>
                      </a>
                      <a
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Activar método"
                        v-if="!status"
                        :id="'times-'+id"
                      >
                        <i class="fa fa-check-circle text-secondary"></i>
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
import { DataTable } from "simple-datatables";
import setTooltip from "@/assets/js/tooltip.js";
import listMethods from '../../use-cases/list.methods'
import changeStatusMethod from '../../use-cases/change.status.method'

export default {
  name: "ListMethod",
  data(){
    return{
      methods: [],
      datatable: {},
    }
  },
  async mounted() {
    await this.datatableMethods()
    setTooltip(this.$store.state.bootstrap);



  },
  methods:{
    async listMethods(){
      const response = {...await listMethods()};
      const {error, data} = response;
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
       if (document.getElementById("methods-list")) {
        this.datatable = new DataTable("#methods-list", {
        searchable: true,
        fixedHeight: false,
        perPage: 5,
        labels: {
            placeholder: "Buscar...", // The search input placeholder
            perPage: "{select} Registros por página", // per-page dropdown label
            noRows: "Ningún dato encontrado", // Message shown when there are no search results
            info: "Mostrando {start} de {end} de {rows} registros",  //
            noResults: "No hay resultados que coincidan con su búsqueda"
        },


          });
        this.datatable.on('datatable.page', () =>{
              this.eventListeners()
        })
        //En valoración
        // this.datatable.on('datatable.perPage', function (event) {
        //       var perPage = event.detail.perPage;
        // });
        }
      this.eventListeners()
    },
    async changeStatus(id){
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
                const response = {...await changeStatusMethod(id)};
                const {error, data, message} = response;
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
    eventListeners(){
          let elementos = document.querySelectorAll('[id*="times"]');
          const method = this.changeStatus;

          elementos.forEach(function(elemento) {
              elemento.addEventListener('click', async function() {
                  const id = elemento.id.toString().split('-')[1]
                  await method(id)
              });
          });
    }
  }
};
</script>
