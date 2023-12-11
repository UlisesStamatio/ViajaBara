<template>
<Loader :isLoading="isLoading"/>
  <div class="py-4 container-fluid" v-show="!isLoading">
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
                    :to="{ name: 'Registrar Usuario' }"
                    class="mb-0 btn bg-gradient-danger btn-sm"
                    >+&nbsp; Nuevo Conductor</router-link
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body mx-4 my-3">
            <div class="table-responsive">
              <table id="drivers-list" class="table table-flush">
                <thead class="thead-light">
                  <tr>
                    <th  style="font-size: 0.65em; font-weight: bold; text-align: start">#</th>
                    <th style="font-size: 0.65em; font-weight: bold">Nombre</th>
                    <th style="font-size: 0.65em; font-weight: bold">Correo</th>
                    <th style="font-size: 0.65em; font-weight: bold">Usuario</th>
                    <th style="font-size: 0.65em; font-weight: bold">Estatus</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Acciones</th>

                  </tr>
                </thead>
              <tbody >
                  <tr v-for="({email, name, username, status, id}, index) in users" :key="index">
                    <td>
                      {{(index + 1)}}
                    </td>
                     <td class="text-sm">{{name}}</td>
                    <td class="text-sm">{{email}}</td>
                    <td class="text-sm">{{username}}</td>
                    <td>
                      <span class="badge  badge-sm" :class="{'badge-success': status, 'badge-danger': !status}"
                        >{{status ? 'Activo' : 'Inactivo'}}</span
                      >
                    </td>
                    <td class="text-sm">

                      <a
                        title="Actualizar conductor"
                        @click="updateDriver(id)"
                        class="clickeable"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                      
                        <a
                        title="Visualizar conductor"
                        @click="detailDriver(id)"
                        class="mx-3 clickeable"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        title="Desactivar conductor"
                        @click="changeStatusDriver(id, username)"
                        class="clickeable"
                        v-if="status"
                      >
                        <i class="fa fa-times-circle text-secondary" ></i>
                      </a>
                        <a
                        title="Activar conductor"
                        @click="changeStatusDriver(id, username)"
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

        <div class="card" v-show="!active">
          <!-- Card header -->
          <div class="pb-0 card-header">
            <div class="d-lg-flex">
              <div>
                <h5 class="mb-0">Lista de clientes</h5>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body  mx-4 my-3">
            <div class="table-responsive">
              <table id="clients-list" class="table table-flush">
                <thead class="thead-light">
                  <tr>
                    <th style="font-size: 0.65em; font-weight: bold; text-align: start">#</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Nombre</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Correo</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Usuario</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Estatus</th>
                    <th style="font-size: 0.65em; font-weight: bold;">Acciones</th>
                  </tr>
                </thead>
              <tbody>
                  
                  <tr v-for="({email, name, username, status, id }, index) in consumers" :key="index">
                    <td>
                      {{(index + 1)}}
                    </td>
                    <td class="text-sm">{{name}}</td>
                    <td class="text-sm">{{email}}</td>
                    <td class="text-sm">{{username}}</td>
                    <td>
                      <span class="badge  badge-sm" :class="{'badge-success': status, 'badge-danger': !status}"
                        >{{status ? 'Activo' : 'Inactivo'}}</span
                      >
                    </td>
                    <td class="text-sm">
                        <a
                        title="Visualizar cliente"
                        @click="detailDriver(id)"
                        class="clickeable me-2"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        title="Desactivar cliente"
                        @click="changeStatusClient(id,username )"
                        class="clickeable"
                        v-if="status"
                      >
                        <i class="fa fa-times-circle text-secondary" ></i>
                      </a>
                        <a
                        title="Activar cliente"
                        @click="changeStatusClient(id, username)"
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
import setNavPills from "@/assets/js/nav-pills.js";
import DataTable from 'datatables.net-dt';
import setTooltip from "@/assets/js/tooltip.js";
import listUsers from '../../use-cases/list.user.js'
import listConsumers from '../../use-cases/list.consumers.js'
import changeStatusUser from '../../use-cases/change.status.user'
import Loader from '../../../../components/Loader.vue'
import $ from 'jquery';
import router from '../../../../router/index'

export default {
  name: "ProductsList",
  components:{
    Loader,
  },
  data(){
    return{
      users: [],
      consumers: [],
      active: true,
      value: true,
      isLoading: false,
      storeDatatableDriver: null,
      storeDatatableClient: null
    }
  },

  async mounted() {
    setNavPills();
    this.active = true;
    await this.datatableDriver();
    setTooltip(this.$store.state.bootstrap);



  },
  methods:{
    async listUsers(){
      this.isLoading = true;
      const response = {...await listUsers()};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.users = result.map(user => ({...user, name: user.person.name === '' && (user.person.surname === ' ' ||  user.person.surname === '')? 'Sin nombre' : `${user.person.name} ${user.person.surname}`}))

      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    async listConsumers(){
      this.isLoading = true;
      const response = {...await listConsumers()};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.consumers = result.map(user => ({...user, name: user.person.name === '' && (user.person.surname === ' ' ||  user.person.surname === '')? 'Sin nombre' : `${user.person.name} ${user.person.surname}`}))
      }else{
          this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
        });
      }
    },
    async changeStatusDriver (id, name){
      await this.changeStatus(id, 1,name)
    },
    async changeStatusClient(id, name){
      await this.changeStatus(id, 2, name)
    },
    async changeStatus(id, type, name){
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
                    if(type === 1) await this.datatableDriver()
                    await this.datatableClient()
                  this.isLoading = false;
                }else{
                  this.isLoading = false;
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
          if(this.storeDatatableDriver){
            this.storeDatatableDriver.destroy()
          }
          this.$nextTick(()=>{
            this.storeDatatableDriver =  new DataTable('#drivers-list', {
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
                  $('#drivers-list_previous').addClass('d-none');
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
    async datatableClient(){
          await this.listConsumers();
           if(this.storeDatatableClient){
            this.storeDatatableClient.destroy()
          }
          this.$nextTick(()=>{
            this.storeDatatableClient =  new DataTable('#clients-list', {
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
                  $('#clients-list_previous').addClass('d-none');
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
    async changeTab(tab){
      if(tab === 1){
        await this.datatableDriver();
        this.active=true;
      }else{
        await this.datatableClient();
        this.active=false;
      } 
    },
    detailDriver(id){
      router.push({name: 'Visualizar Usuario', params: {id: id}})
    },
    updateDriver(id){
      router.push({name: 'Modificar Usuario', params: {id: id}})
    }
  },
  watch:{
    users: async function(){
    }
  }
  

};
</script>

<style scoped>
  .clickeable{
    cursor: pointer;
  }
</style>
