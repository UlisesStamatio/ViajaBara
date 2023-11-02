<template>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-lg-4 mb-2">
          <div class="nav-wrapper position-relative end-0">
            <ul class="nav nav-pills nav-fill p-1" role="tablist">
              <li class="nav-item">
                <a
                  class="nav-link mb-0 px-0 py-1"
                  :class="{'active active': active}"
                  data-bs-toggle="tab"
                  role="tab"
                  aria-selected="true"
                  @click="changeTab(1)"
                  style="cursor:pointer;"
                  >Conductores</a
                >
              </li>
              <li class="nav-item">
                <a
                  class="nav-link mb-0 px-0 py-1"
                  data-bs-toggle="tab"
                  :class="{'active active': !active}"
                  role="tab"
                  @click="changeTab(2)"
                  style="cursor:pointer;"
                  aria-selected="false"
                  >Clientes</a
                >
              </li>
            </ul>
        </div>
      </div>
      <div class="col-12">

        <div class="card" v-show="active">

          <!-- Card header -->
          <div class="pb-0 card-header">
            <div class="d-lg-flex">
              <div>
                <h5 class="mb-0">Lista de conductores</h5>
              </div>
              <div class="my-auto mt-4 ms-auto mt-lg-0">
                <div class="my-auto ms-auto">
                  <router-link
                    :to="{ name: 'Registro Usuario' }"
                    class="mb-0 btn bg-gradient-primary btn-sm"
                    >+&nbsp; Nuevo Conductor</router-link
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body">
            <div class="table-responsive">
              
              <table id="drivers-list" class="table table-flush">

                <thead class="thead-light">
                  <tr>
                    
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Usuario</th>
                    <th>Rol</th>
                    <th>Estatus</th>
                    <th>Acciones</th>

                  </tr>
                </thead>
              <tbody v-if="users.length !== 0">
                  <tr v-for="({email, person:{name, surname}, username, roles, status, id}, index) in users" :key="index">
                    <td>
                      {{(index + 1)}}
                    </td>
                    <td class="text-sm">{{name + ' ' + surname}}</td>
                    <td class="text-sm">{{email}}</td>
                    <td class="text-sm">{{username}}</td>
                    <td class="text-sm">{{roles.length > 0 ? roles[0].name.toLowerCase() : 'Sin rol'}}</td>
                    <td>
                      <span class="badge  badge-sm" :class="{'badge-success': status, 'badge-danger': !status}"
                        >{{status ? 'Activo' : 'Inactivo'}}</span
                      >
                    </td>
                    <td class="text-sm">

                      <router-link
                        :to="{ name: 'Modificar Usuario', params: {id: id} }"

                        data-bs-toggle="tooltip"
                        data-bs-original-title="Editar usuario"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </router-link>
                      
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Detalles del usuario"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        v-cloak
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Desactivar usuario"
                        v-if="status"
                        :id="'times-' + id"
                      >
                        <i class="fa fa-times-circle text-secondary" ></i>
                      </a>
                        <a
                        v-cloak
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Activar usuario"
                        v-if="!status"
                        :id="'times-' + id"
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

        <div class="card" v-show="!active">
          <!-- Card header -->
          <div class="pb-0 card-header">
            <div class="d-lg-flex">
              <div>
                <h5 class="mb-0">Lista de clientes</h5>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body">
            <div class="table-responsive">
              <table id="clients-list" class="table table-flush">
                <thead class="thead-light">
                  <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Usuario</th>
                    <th>Rol</th>
                    <th>Estatus</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
              <tbody v-if="consumers.length !== 0">
                  
                  <tr v-for="({email, person:{name, surname}, username, roles, status, id }, index) in consumers" :key="index">
                    <td>
                      {{(index + 1)}}
                    </td>
                    <td class="text-sm">{{name + ' ' + surname}}</td>
                    <td class="text-sm">{{email}}</td>
                    <td class="text-sm">{{username}}</td>
                    <td class="text-sm">{{roles.length > 0 ? roles[0].name.toLowerCase() : 'Sin rol'}}</td>
                    <td>
                      <span class="badge  badge-sm" :class="{'badge-success': status, 'badge-danger': !status}"
                        >{{status ? 'Activo' : 'Inactivo'}}</span
                      >
                    </td>
                    <td class="text-sm">

                      
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Detalles del usuario"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                     <a
                        v-cloak
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Desactivar usuario"
                        v-if="status"
                        :id="'times-' + id"
                      >
                        <i class="fa fa-times-circle text-secondary" ></i>
                      </a>
                        <a
                        v-cloak
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Activar usuario"
                        v-if="!status"
                        :id="'times-' + id"
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
import setNavPills from "@/assets/js/nav-pills.js";
import { DataTable } from "simple-datatables";
import setTooltip from "@/assets/js/tooltip.js";
import listUsers from '../../use-cases/list.user.js'
import listConsumers from '../../use-cases/list.consumers.js'
import changeStatusUser from '../../use-cases/change.status.user'
//import router from '../../../../router/index'



export default {
  name: "ProductsList",
  data(){
    return{
      users: [],
      consumers: [],
      active: true,
      value: true,
    }
  },

  async mounted() {
    setNavPills();
    this.active = true;
    await this.datatableDriver();
    this.eventListeners()
    setTooltip(this.$store.state.bootstrap);



  },
  methods:{
    async listUsers(){
      const response = {...await listUsers()};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.users = result
          console.log(this.users);
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async listConsumers(){
      const response = {...await listConsumers()};
      const {error, data} = response;
      if(!error){
          const {result} = data
          this.consumers = result
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
        });
      }
    },
    async changeStatus(id){
      console.log("Entro aqui ", id);
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
                const response = {...await changeStatusUser(id)};
                const {error, data, message} = response;
                if(!error){
                    const {result:{text}} =data
                    this.$swal({
                      icon: "success",
                      title: message,
                      text: text,
                      type: 'success-message',
                    });
                    await this.datatableDriver()
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
    async datatableDriver(){
          await this.listUsers();
          if (document.getElementById("drivers-list")) {
          new DataTable("#drivers-list", {
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
          }
    },
    async datatableClient(){
          await this.listConsumers();
          if (document.getElementById("clients-list")) {
          new DataTable("#clients-list", {
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
          }
    },
    async changeTab(tab){
      if(tab === 1){
        await this.datatableDriver();
        this.eventListeners()
        this.active=true;
      }else{
        await this.datatableClient();
        this.eventListeners()
        this.active=false;
      } 
    },
     eventListeners(){
          let elementos = document.querySelectorAll('[id*="times"]');
          console.log(elementos);
          const method = this.changeStatus;

          elementos.forEach(function(elemento) {
              elemento.addEventListener('click', async function() {
                  const id = elemento.id.toString().split('-')[1]
                  await method(id)
              });
          });
    }
  },
  watch:{
    users: async function(){
      console.log("Hola");
    }
  }
  

};
</script>
