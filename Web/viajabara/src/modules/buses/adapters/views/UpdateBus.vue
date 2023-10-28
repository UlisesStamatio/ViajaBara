<template>
  <div class="py-4 container-fluid">
    <div class="mt-4 row">
      <div class="col-lg-4">
        <div class="card h-100">
          <div class="card-body">
            <h5 class="font-weight-bolder">Imagen del autobus</h5>
            <div class="row">
              <div class="col-12">
                <img
                  class="mt-3 shadow-lg w-100 border-radius-lg"
                  src="https://tse3.mm.bing.net/th?id=OIP.v0MSU6CNCuK6R0IRrmZfzQHaE8&pid=Api&P=0&h=180"
                  alt="autobus_image"
                />
              </div>
              <div class="mt-4 col-12">
                <div class="d-flex">
                  <button
                    class="mb-0 btn bg-gradient-primary btn-sm me-2"
                    type="button"
                    name="button"
                  >
                    Editar
                  </button>
                  <button
                    class="mb-0 btn btn-outline-dark btn-sm"
                    type="button"
                    name="button"
                  >
                    Remover
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="mt-4 col-lg-8 mt-lg-0">
        <div class="card h-100">
          <div class="card-body">
            <h5 class="font-weight-bolder">Información del autobus</h5>
            <div class="row mt-3">
              <div class="col-12 col-sm-6">
                <label>Placa(<span class="text-danger">*</span>)</label>
                <soft-input
                    id="name"
                    type="text"
                    placeholder="e.g. PUJ23J"
                    name="name"
                    size=""
                    value="PUJ23J"
                />
              </div>
              <div class="mt-3 col-12 col-sm-6 mt-sm-0">
               <label>Marca(<span class="text-danger">*</span>)</label>
                <soft-input
                    id="name"
                    type="text"
                    placeholder="e.g. Vogager"
                    name="name"
                    size=""
                    value="Vogager"
                />
              </div>
            </div>
            <div class="row">
              <div class="col-12 col-sm-6">
                <label>Modelo(<span class="text-danger">*</span>)</label>
                <soft-input
                    id="name"
                    type="text"
                    placeholder="e.g. Vogager 2023"
                    name="name"
                    size=""
                    value="Vogager 2023"
                />
              </div>
              <div class="mt-3 col-12 col-sm-6 mt-sm-0">
               <label>Número de serie(<span class="text-danger">*</span>)</label>
                <soft-input
                    id="name"
                    type="text"
                    placeholder="eg. 277347832"
                    name="name"
                    size=""
                    value="277347832"
                />
              </div>
            </div>
            <div class="row">
              <div class="col-12 col-sm-6">
                <label>Capacidad(<span class="text-danger">*</span>)</label>
                <soft-input
                    id="name"
                    type="number"
                    placeholder="e.g. 39"
                    name="name"
                    size=""
                    value="39"
                />
              </div>
              <div class="mt-3 col-12 col-sm-6 mt-sm-0">
               <label>Combustible(<span class="text-danger">*</span>)</label>
                <soft-input
                    id="name"
                    type="text"
                    placeholder="eg. Diesel"
                    name="name"
                    size=""
                    value="Diesel"
                />
              </div>
            </div>


            <div class="row mt-5">
                <div class="col-12 text-end ">
                <soft-button
                    type="button"
                    color="secondary"
                    variant="gradient"
                    class="mb-0 me-2 ms-auto js-btn-next"
                    title="Next"
                    @click="this.$parent.nextStep"
                    >Cancelar</soft-button>
                <soft-button
                    type="button"
                    color="dark"
                    variant="gradient"
                    class="mb-0 ms-auto js-btn-next"
                    title="Next"
                    @click="this.$parent.nextStep"
                    >Guardar</soft-button>
                </div>
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Quill from "quill";
import Choices from "choices.js";
import SoftInput from "@/components/SoftInput.vue";
import SoftButton from "@/components/SoftButton.vue";

export default {
  name: "UpdateBus",
   components: {
    SoftInput,
    SoftButton,
  },

  mounted() {
    if (document.getElementById("edit-description-edit")) {
      new Quill("#edit-description-edit", {
        theme: "snow", // Specify theme in configuration
      });
    }
    this.getChoices("choices-category-edit");
    this.getChoices("choices-color-edit");
    this.getChoices("choices-currency-edit");

    if (document.getElementById("choices-tags-edit")) {
      var tags = document.getElementById("choices-tags-edit");
      const examples = new Choices(tags, {
        removeItemButton: true,
      });

      examples.setChoices(
        [
          {
            value: "One",
            label: "Expired",
            disabled: true,
          },
          {
            value: "Two",
            label: "Out of Stock",
            selected: true,
          },
        ],
        "value",
        "label",
        false
      );
    }
  },
  methods: {
    getChoices(id) {
      if (document.getElementById(id)) {
        var element = document.getElementById(id);
        return new Choices(element, {
          searchEnabled: false,
        });
      }
    },
  },
};
</script>
