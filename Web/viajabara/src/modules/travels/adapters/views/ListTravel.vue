<template>
  <div class="py-4 container-fluid">
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
                    :to="{ name: 'Registro Viaje' }"
                    class="mb-0 btn bg-gradient-primary btn-sm"
                    >+&nbsp; Nuevo Viaje</router-link
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
                    <th>Conductor</th>
                    <th>Autobus</th>
                    <th>Ruta</th>
                    <th>Fecha</th>
                    <th>Servicio</th>
                    <th>Estatus</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>
                      1
                    </td>
                    <td class="text-sm">Paula Rodríguez González</td>
                    <td class="text-sm">23456789</td>
                    <td class="text-sm">Cuernavaca - Jiutepec</td>
                    <td class="text-sm">15-10-2023 17:30</td>
                    <td class="text-sm">Ida y vuelta</td>
                    <td>
                      <span class="badge badge-success badge-sm"
                        >Activo</span
                      >
                    </td>
                    <td class="text-sm">

                      <router-link
                        :to="{ name: 'Modificar Viaje' }"

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
                    <td class="text-sm">Laura González López</td>
                    <td class="text-sm">98765432</td>
                    <td class="text-sm">Temixco - Toluca</td>
                    <td class="text-sm">15-10-2023 20:30</td>
                    <td class="text-sm">Ida y vuelta</td>
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
                    <td class="text-sm">María Torres Ruiz</td>
                    <td class="text-sm">12345678</td>
                    <td class="text-sm">Alpuyeca - Tres Marías</td>
                    <td class="text-sm">16-10-2023 17:30</td>
                    <td class="text-sm">Ida y vuelta</td>
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
                    <td class="text-sm">Javier López Martínez</td>
                    <td class="text-sm">87654321</td>
                    <td class="text-sm">Ciudad de México - Cuernavaca</td>
                    <td class="text-sm">25-10-2023 08:30</td>
                    <td class="text-sm">Solo ida</td>
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
                    <td class="text-sm">Paula Rodríguez González</td>
                    <td class="text-sm">34567890</td>
                    <td class="text-sm">Monterrey - Querétaro</td>
                    <td class="text-sm">26-10-2023 11:30</td>
                    <td class="text-sm">Ida y vuelta</td>
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
                    <td class="text-sm">Alejandro Martínez García</td>
                    <td class="text-sm">23456789</td>
                    <td class="text-sm">Cuernavaca - Jiutepec</td>
                    <td class="text-sm">01-11-2023 06:30</td>
                    <td class="text-sm">Solo ida</td>
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
                    <td class="text-sm">Laura González López</td>
                    <td class="text-sm">98765432</td>
                    <td class="text-sm">Temixco - Toluca</td>
                    <td class="text-sm">20-11-2023 18:30</td>
                    <td class="text-sm">Ida y vuelta</td>
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
                    <td class="text-sm">Ida y vuelta</td>
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
                    <td class="text-sm">Ida y vuelta</td>
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
  name: "ListTravel",
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
};
</script>
