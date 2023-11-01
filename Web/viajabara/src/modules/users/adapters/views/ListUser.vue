<template>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <!-- Card header -->
          <div class="pb-0 card-header">
            <div class="d-lg-flex">
              <div>
                <h5 class="mb-0">Lista de usuarios</h5>
              </div>
              <div class="my-auto mt-4 ms-auto mt-lg-0">
                <div class="my-auto ms-auto">
                  <router-link
                    :to="{ name: 'Registro Usuario' }"
                    class="mb-0 btn bg-gradient-primary btn-sm"
                    >+&nbsp; Nuevo Usuario</router-link
                  >
                </div>
              </div>
            </div>
          </div>
          <div class="px-0 pb-0 card-body">
            <div class="table-responsive">
              <table id="products-list" class="table table-flush">
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
                               <tbody>
                  <tr>
                    <td>
                      1
                    </td>
                    <td class="text-sm">Isabel Rodríguez Pérez</td>
                    <td class="text-sm">isabel.rodriguez@example.com</td>
                    <td class="text-sm">AmigaComprensiva</td>
                    <td class="text-sm">Conductor</td>
                    <td>
                      <span class="badge badge-success badge-sm"
                        >Activo</span
                      >
                    </td>
                    <td class="text-sm">

                      <router-link
                        :to="{ name: 'Modificar Usuario' }"

                        data-bs-toggle="tooltip"
                        data-bs-original-title="Editar producto"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </router-link>
                      
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fa fa-times-circle text-secondary"></i>
                      </a>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      2
                    </td>
                    <td class="text-sm">Alejandro Martínez García</td>
                    <td class="text-sm">alejandro.martinez@example.com</td>
                    <td class="text-sm">SonrisaRadiante</td>
                    <td class="text-sm">Conductor</td>
                    <td>
                      <span class="badge badge-success badge-sm"
                        >Activo</span
                      >
                    </td>
                     <td class="text-sm">

                      <a
                        href="javascript:;"

                        data-bs-toggle="tooltip"
                        data-bs-original-title="Edit product"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fa fa-times-circle text-secondary"></i>
                      </a>
                    </td>
                  </tr>

                  <tr>
                    <td>
                      3
                    </td>
                    <td class="text-sm">Laura González López</td>
                    <td class="text-sm">laura.gonzalez@example.com</td>
                    <td class="text-sm">AventureroAudaz</td>
                    <td class="text-sm">Conductor</td>
                    <td>
                      <span class="badge badge-success badge-sm">Activo</span>
                    </td>
                      <td class="text-sm">

                      <a
                        href="javascript:;"

                        data-bs-toggle="tooltip"
                        data-bs-original-title="Edit product"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fa fa-times-circle text-secondary"></i>
                      </a>
                    </td>
                  </tr>
                  <tr>
                    <td>
                     4
                    </td>
                    <td class="text-sm">Carlos Sánchez Fernández</td>
                    <td class="text-sm">carlos.sanchez@example.com</td>
                    <td class="text-sm">LunaEnamorada</td>
                    <td class="text-sm">Cliente</td>
                    <td>
                      <span class="badge badge-success badge-sm"
                        >Activo</span
                      >
                    </td>
                    <td class="text-sm">

                      <a
                        href="javascript:;"

                        data-bs-toggle="tooltip"
                        data-bs-original-title="Edit product"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fa fa-times-circle text-secondary"></i>
                      </a>
                    </td>
                  </tr>
                  <tr>
                    <td>
                     5
                    </td>
                    <td class="text-sm">María Torres Ruiz</td>
                    <td class="text-sm">maria.torres@example.com</td>
                    <td class="text-sm">ViajeroIntrépido</td>
                    <td class="text-sm">Conductor</td>
                    <td>
                      <span class="badge badge-success badge-sm">Activo</span>
                    </td>
                    <td class="text-sm">

                      <a
                        href="javascript:;"

                        data-bs-toggle="tooltip"
                        data-bs-original-title="Edit product"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fa fa-times-circle text-secondary"></i>
                      </a>
                    </td>
                  </tr>
                  <tr>
                    <td>
                     6
                    </td>
                    <td class="text-sm">Javier López Martínez</td>
                    <td class="text-sm">javier.lopez@example.com</td>
                    <td class="text-sm">MariposaFeliz</td>
                    <td class="text-sm">Conductor</td>
                    <td>
                      <span class="badge badge-danger badge-sm">Inactivo</span>
                    </td>
                   <td class="text-sm">

                      <a
                        href="javascript:;"

                        data-bs-toggle="tooltip"
                        data-bs-original-title="Edit product"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fa fa-check-circle text-secondary"></i>
                      </a>
                    </td>
                  </tr>
                  <tr>
                    <td>
                     7
                    </td>
                    <td class="text-sm">Paula Rodríguez González</td>
                    <td class="text-sm">paula.rodriguez@example.com</td>
                    <td class="text-sm">ExploradorValiente</td>
                    <td class="text-sm">Conductor</td>
                    <td>
                      <span class="badge badge-danger badge-sm">Inactivo</span>
                    </td>
                    <td class="text-sm">

                      <a
                        href="javascript:;"

                        data-bs-toggle="tooltip"
                        data-bs-original-title="Edit product"
                      >
                        <i class="fa fa-pencil-square-o text-secondary"></i>
                      </a>
                        <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fa fa-check-circle text-secondary"></i>
                      </a>
                    </td>
                  </tr>
                  <tr>
                    <td>
                     8
                    </td>
                    <td class="text-sm">Clothing</td>
                    <td class="text-sm">$1,199</td>
                    <td class="text-sm">00121399</td>
                    <td class="text-sm">51293</td>
                    <td>
                      <span class="badge badge-success badge-sm">in Stock</span>
                    </td>
                    <td class="text-sm">
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Edit product"
                      >
                        <i class="fas fa-user-edit text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fas fa-trash text-secondary"></i>
                      </a>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      9
                    </td>
                    <td class="text-sm">Furniture</td>
                    <td class="text-sm">$1,900</td>
                    <td class="text-sm">434729</td>
                    <td class="text-sm">1100191321</td>
                    <td>
                      <span class="badge badge-success badge-sm">In Stock</span>
                    </td>
                    <td class="text-sm">
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Preview product"
                      >
                        <i class="fas fa-eye text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        class="mx-3"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Edit product"
                      >
                        <i class="fas fa-user-edit text-secondary"></i>
                      </a>
                      <a
                        href="javascript:;"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Delete product"
                      >
                        <i class="fas fa-trash text-secondary"></i>
                      </a>
                    </td>
                  </tr>

                </tbody>
                 <tfoot>
                  <tr>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>SKU</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
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


export default {
  name: "ProductsList",
  data(){
    return{
      users: [],
    }
  },
  mounted() {
    if (document.getElementById("products-list")) {
      const dataTableSearch = new DataTable("#products-list", {
        searchable: true,
        fixedHeight: false,
        perPage: 7,
        labels: {
            placeholder: "Buscar...", // The search input placeholder
            perPage: "{select} Registros por página", // per-page dropdown label
            noRows: "Ningún dato encontrado", // Message shown when there are no search results
            info: "Mostrando {start} de {end} de {rows} registros",  //
            noResults: "No hay resultados que coincidan con su búsqueda"
        },
        
      });

      document.querySelectorAll(".export").forEach(function (el) {
        el.addEventListener("click", function () {
          var type = el.dataset.type;

          var data = {
            type: type,
            filename: "soft-ui-" + type,
          };

          if (type === "csv") {
            data.columnDelimiter = "|";
          }

          dataTableSearch.export(data);
        });
      });
    }
    setTooltip(this.$store.state.bootstrap);
  },
  methods:{
    async listUsers(){
      console.log("List users");
    }
  }
};
</script>
