<template>
  <navbar
    is-blur="blur blur-rounded my-3 py-2 start-0 end-0 mx-4 shadow"
    btn-background="bg-gradient-primary"
    :dark-mode="true"
  />
  <div
    class="m-3 page-header bg-gradient-primary position-relative border-radius-xl"
  >
    <!-- <img
      src="../../assets/img/shapes/waves-white.svg"
      alt="pattern-lines"
      class="top-0 position-absolute opacity-6 start-0 w-100"
    /> -->
    <section
      class="container-fluid pb-5 pt-7 postion-relative z-index-2"
      id="home"
    >
      <div class="row">
        <div class="mx-auto text-center col-md-6">
          <div class="row">
            <div
              class="col-12 text-white"
              style="font-size: 5rem; font-family: 'Parisienne', cursive;"
            >
              ViajaBara
            </div>
            <div
              class="col-12 text-white"
              style="
                font-size: 5rem;
                font-family: 'Parisienne', cursive;
                font-style: italic;
              "
            >
              y de volada
            </div>
            <div class="col-12 text-white mt-4">
              Para ViajaBara tu salud es lo más importante, por ello tomamos las
              medidas sanitarias necesarias para brindarte la mayor seguridad en
              tus viajes. Utiliza tu cubrebocas durante el viaje. ¡cuidémonos¡
            </div>
          </div>
        </div>
        <div class="mx-auto text-center col-md-6 mx-2 d-none d-lg-block">
          <img
            src="../../../../assets/img/landing-image.png"
            class="img-fluid"
            srcset=""
          />
        </div>
      </div>
    </section>
  </div>

  <div class="container my-6">
    <section class="container" id="who">
      <div class="row">
        <div class="col-12 text-center">
          <h2>¿Quiénes somos?</h2>
          <p class="mt-5">
            ViajaBara SAS de CV es una empresa de transporte comprometida con
            brindarte un servicio de calidad en cada uno de tus viajes.
          </p>
          <p class="mt-3 fw-bold">
            Contamos con el mejor servicio del mercado teniendo vans con confort
            premium, climatizadas y asientos reclinables además de contar con
            una operación 100% regulada, choferes expertos con licencia federal
            para garantizar la aeguridad y protección total con nuestro seguro
            de viajero, nuestras vans están listas para todo y siempre limpias
            siguiendo protocolos sanitarios.
          </p>
          <p class="mt-2 fw-bold">¡También gestionamos envíos de paquetería!</p>
          <p class="mt-2">
            ViajaBara es una nueva forma de viajar, ViajaBara te ofrece un
            transporte rápido, cómodo y seguro. ¡Vive la experiencia de viajar
            con ViajaBara¡
          </p>
        </div>
        <div class="col-12 text-center"></div>
      </div>
    </section>
    <hr class="mt-5 mb-2 horizontal dark" />
    <section class="container" id="route">
      <div class="row">
        <div class="col-12 text-center">
          <h2 class="mb-5">Ruta Actual</h2>
          <div class="row">
            <div class="col-12 text-start ms-5 mb-3">
              <h6 class="text-secondary">Cuernavaca - Puebla</h6>
            </div>
            <div class="col-12 ">
              <div class="multisteps-form__progress mb-5">
            <button
              class="multisteps-form__progress-btn js-active"
              type="button"
              title="User Info"
              :class="activeStep >= 0 ? activeClass : ''"
              @click="activeStep = 0"
            >
              <span class="d-block">Parque alameda</span>
              <span class="d-block">Walmart Jiutepec</span>
              <span class="d-block">Parada UPEMOR</span>
            </button>
            <button
              class="multisteps-form__progress-btn js-active"
              type="button"
              title="Address"
              :class="activeStep >= 1 ? activeClass : ''"
              @click="activeStep = 1"
            >
              <span class="d-block">Cecina Yecapixtla</span>
            </button>
            <button
              class="multisteps-form__progress-btn js-active"
              type="button"
              title="Socials"
              :class="activeStep >= 2 ? activeClass : ''"
              @click="activeStep = 2"
            >
              <span class="d-block">Plaza Aventura</span>
            </button>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-12 text-start ms-5 mb-3">
                <h6 class="text-secondary">Puebla - Cuernavaca </h6>
            </div>
            <div class="col-12">
                  <div class="multisteps-form__progress">
                    <button
                      class="multisteps-form__progress-btn js-active"
                      type="button"
                      title="User Info"
                      :class="activeStep >= 0 ? activeClass : ''"
                      @click="activeStep = 0"
                    >
                      <span class="d-block">Café Yaguar Tlaxcalancingo</span>
                    </button>
                    <button
                      class="multisteps-form__progress-btn js-active"
                      type="button"
                      title="Address"
                      :class="activeStep >= 1 ? activeClass : ''"
                      @click="activeStep = 1"
                    >
                      <span class="d-block">Parada Home Depot Cuautla</span>
                    </button>
                    <button
                      class="multisteps-form__progress-btn js-active"
                      type="button"
                      title="Socials"
                      :class="activeStep >= 2 ? activeClass : ''"
                      @click="activeStep = 2"
                    >
                      <span class="d-block">IMSS Cuernavaca</span>
                    </button>
                  </div>
            </div>
          </div>

        </div>
      </div>
    </section>

    <hr class="mt-5 mb-2 horizontal dark" />
    <section class="container" id="services">
      <div class="row">
        <div class="col-12 text-center"><h2>Servicios adicionales</h2></div>
        <div class="col-12 mt-5 col-md-3">
          <div class="card">
            <div
              class="py-3 text-center card-header d-flex justify-content-center"
            >
              <div
                class="icon icon-shape icon-lg shadow text-center border-radius-lg bg-gradient-primary"
              >
                <i
                  class="opacity-10 text-white fas fa-bus"
                  aria-hidden="true"
                  style="font-size: 32px"
                ></i>
              </div>
            </div>
            <div class="p-3 pt-0 text-center card-body">
              <h6 class="mb-0 text-center">Transporte Escolar</h6>
            </div>
          </div>
        </div>
        <div class="col-12 mt-5 col-md-3">
          <div class="card">
            <div
              class="py-3 text-center card-header d-flex justify-content-center"
            >
              <div
                class="icon icon-shape icon-lg shadow text-center border-radius-lg bg-gradient-primary"
              >
                <i
                  class="opacity-10 text-white fas fa-bus"
                  aria-hidden="true"
                  style="font-size: 32px"
                ></i>
              </div>
            </div>
            <div class="p-3 pt-0 text-center card-body">
              <h6 class="mb-0 text-center">Transporte Turistico</h6>
            </div>
          </div>
        </div>
        <div class="col-12 mt-5 col-md-3">
          <div class="card">
            <div
              class="py-3 text-center card-header d-flex justify-content-center"
            >
              <div
                class="icon icon-shape icon-lg shadow text-center border-radius-lg bg-gradient-primary"
              >
                <i
                  class="opacity-10 text-white fas fa-car"
                  aria-hidden="true"
                  style="font-size: 32px"
                ></i>
              </div>
            </div>
            <div class="p-3 pt-0 text-center card-body">
              <h6 class="mb-0 text-center">
                Transporte para eventos y empresas
              </h6>
            </div>
          </div>
        </div>
        <div class="col-12 col-md-3 mt-5">
          <div class="card">
            <div
              class="py-3 text-center card-header d-flex justify-content-center"
            >
              <div
                class="icon icon-shape icon-lg shadow text-center border-radius-lg bg-gradient-primary"
              >
                <i
                  class="opacity-10 text-white fas fa-box"
                  aria-hidden="true"
                  style="font-size: 32px"
                ></i>
              </div>
            </div>
            <div class="p-3 pt-0 text-center card-body">
              <h6 class="mb-0 text-center">Paquetería</h6>
            </div>
          </div>
        </div>
      </div>
    </section>

    <hr class="mt-5 mb-2 horizontal dark" />
    <section class="container pb-5" id="quotes">
      <div class="row">
        <div class="col-12 text-center"><h2>Cotiza tu viaje</h2></div>
        <div class="col-12 mt-5">
          <div class="card">
            <div class="card-body">
              <h5 class="font-weight-bolder">Información del viaje</h5>
              <div class="row mt-3">
                <div class="col-12 col-sm-6 mb-3">
                  <label
                    >Nombre completo(<span class="text-danger">*</span>)</label
                  >
                  <input
                    id="plaque"
                    type="text"
                    placeholder="e.g. Luis Smith"
                    name="plaque"
                    class="form-control"
                  />
                </div>
                <div class="col-12 col-sm-6 mb-3 ">
                  <label
                    >Correo electrónico(<span class="text-danger">*</span
                    >)</label
                  >
                  <input
                    id="mark"
                    type="email"
                    placeholder="e.g. luis@gmail.com"
                    name="mark"
                    class="form-control"
                  />
                </div>
              </div>
              <div class="row">
                <div class="col-12 col-sm-6 mb-3">
                  <label
                    >Punto de inicio(<span class="text-danger">*</span>)</label
                  >
                  <select
                    id="state-select"
                    class="form-control"
                    name="state-select"
                  >
                    <option value="" selected disabled>
                      Selecciona una opción...
                    </option>
                    <option value="1">Cuernavaca - Morelos</option>
                    <option value="2">Jiutepec - Morelos</option>
                  </select>
                </div>

                <div class="col-12 col-sm-6 mb-3">
                  <label>Destino(<span class="text-danger">*</span>)</label>
                  <select
                    id="state-select"
                    class="form-control"
                    name="state-select"
                  >
                    <option value="" selected disabled>
                      Selecciona una opción...
                    </option>
                    <option value="1">Polanco - CDMX</option>
                    <option value="2">Acapulco - Guerrero</option>
                  </select>
                </div>

                <div class="col-12 col-sm-6 mb-3">
                  <label
                    >Cantidad de personas(<span class="text-danger">*</span
                    >)</label
                  >
                  <input
                    id="serial"
                    type="number"
                    placeholder="eg. 10"
                    name="serial"
                    class="form-control"
                  />
                </div>

                <div class="col-12 col-sm-6 mb-3">
                  <label
                    >Tipo de servicio(<span class="text-danger">*</span>)</label
                  >
                  <select
                    id="state-select"
                    class="form-control"
                    name="state-select"
                  >
                    <option value="" selected disabled>
                      Selecciona una opción...
                    </option>
                    <option value="1">Ida y vuelta</option>
                    <option value="2">Solo ida</option>
                  </select>
                </div>

                <div class="col-12 col-sm-6 mb-3">
                  <label
                    >Fecha de Inicio(<span class="text-danger">*</span>)</label
                  >
                  <input
                    id="serial"
                    type="date"
                    name="serial"
                    class="form-control"
                  />
                </div>

                <div class="col-12 col-sm-6 mb-3">
                  <label
                    >Fecha de Fin(<span class="text-danger">*</span>)</label
                  >
                  <input
                    id="serial"
                    type="date"
                    name="serial"
                    class="form-control"
                  />
                </div>
              </div>

              <div class="row mt-5">
                <div class="col-12 text-center">
                  <button
                    type="button"
                    class="mb-2 me-2 ms-auto btn js-btn-next bg-gradient-secondary"
                    title="Cancelar"
                  >
                    Cancelar
                  </button>

                  <button
                    type="submit"
                    class="mb-2 ms-auto btn js-btn-next bg-gradient-dark"
                    title="Guardar"
                  >
                    Guardar
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  <footer class="container-fluid bg-gradient-primary" id="contact">
    <div class="row py-2">
      <div class="col-12 text-center text-white">
        <span class="fw-bold" style="font-size: 1.5em">
          <img :src="bus" class="me-2" alt="" />
          ViajaBara
        </span>
      </div>
      <div class="col-12 text-center text-white">
        <span style="font-family: 'monserrat'; font-size: 1.2em">
          Viaja sencillo, barato y de volada.</span
        >
      </div>
      <div class="col-12 mt-3 text-center">
        <a href="javascript:;" target="_blank" class="text-secondary ms-4 me-4">
          <span
            class="fab fa-instagram text-white"
            style="font-size: 2.5em"
          ></span>
        </a>

        <a href="javascript:;" target="_blank" class="text-secondary me-4">
          <span
            class="fab fa-facebook text-white"
            style="font-size: 2.5em"
          ></span>
        </a>

        <a href="javascript:;" target="_blank" class="text-secondary me-4">
          <span
            class="fab fa-whatsapp text-white"
            style="font-size: 2.5em"
          ></span>
        </a>
      </div>
    </div>
  </footer>
</template>
<script>
import Navbar from "@/examples/PageLayout/Navbar.vue";
//import PricingCard from "../../../../views/pages/components/PricingCard.vue";
//import AppFooter from "@/examples/PageLayout/Footer.vue";
//import AccordionItem from "../../../../views/pages/components/AccordionItem.vue";
import setNavPills from "@/assets/js/nav-pills.js";
//import Accordion from "../../../../views/pages/components/Accordion.vue";
import icon from "../../../../assets/img/landing-image.png";
import bus from "../../../../assets/img/bus-footer.png";

export default {
  name: "LandingPage",
  components: {
    Navbar,
    //PricingCard,
    //AppFooter,
    //AccordionItem,
    //Accordion,
  },
  data() {
    return {
      icon,
      bus,
    };
  },
  mounted() {
    this.$store.state.showSidenav = false;
    this.$store.state.showNavbar = false;
    this.$store.state.showFooter = false;
    setNavPills();
  },
  beforeUnmount() {
    this.$store.state.showSidenav = true;
    this.$store.state.showNavbar = true;
    this.$store.state.showFooter = true;
    if (this.$store.state.isPinned === false) {
      const sidenav_show = document.querySelector(".g-sidenav-show");
      sidenav_show.classList.remove("g-sidenav-hidden");
      sidenav_show.classList.add("g-sidenav-pinned");
      this.$store.state.isPinned = true;
    }
  },
};
</script>
