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
              <table id="products-list" class="table table-flush">
                <thead class="thead-light">
                  <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Estatus</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                               <tbody>
                  <tr>
                    <td>
                      1
                    </td>
                    <td class="text-sm">TarjetaElectronicaExpress</td>
                    <td>
                      <span class="badge badge-success badge-sm"
                        >Activo</span
                      >
                    </td>
                    <td class="text-sm">

                      <router-link
                        :to="{ name: 'Modificar Método' }"
                        data-bs-toggle="tooltip"
                        data-bs-original-title="Editar método"
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
                    <td class="text-sm">PagosRapidosConTarjeta</td>
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
                    <td class="text-sm">SeguraCompraEnLinea</td>
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
                    <td class="text-sm">TarjetaDigitalProtegida</td>
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
                    <td class="text-sm">PagoFacilConTarjeta</td>
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
                    <td class="text-sm">SeguridadEnLineaTotal</td>

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
                    <td class="text-sm">MetodoPagoElectronico</td>
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
  name: "ListMethod",
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
