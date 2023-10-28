<template>
  <navbar
   is-blur="blur blur-rounded my-3 py-2 start-0 end-0 mx-4 shadow"
          btn-background="bg-gradient-primary"
          :dark-mode="true" />
  <div class="m-3 page-header bg-gradient-primary position-relative border-radius-xl">
    <!-- <img
      src="../../assets/img/shapes/waves-white.svg"
      alt="pattern-lines"
      class="top-0 position-absolute opacity-6 start-0 w-100"
    /> -->
    <div class="container pb-10 pb-lg-9 pt-7 postion-relative z-index-2">
      <div class="row">
        <div class="mx-auto text-center col-md-6">
          <div class="row">
            <div class="col-12 text-white" style="font-size: 5rem; font-family: 'Work Sans', sans-serif;" >ViajaBara</div>
            <div class="col-12 text-white" style="font-size: 5rem; font-family: 'Parisienne', cursive; font-style:  italic ;"> y de volada</div>
            <div class="col-12 text-white mt-4" > Para ViajaBara tu salud es lo más importante, por ello tomamos las medidas sanitarias necesarias para brindarte la mayor seguridad en tus viajes. Utiliza tu cubrebocas durante el viaje. ¡cuidémonos¡</div>
          </div>
        </div>
         <div class="mx-auto text-center col-md-6 mx-2 d-none d-lg-block" >
          <img src="../../../../assets/img/landing-image.png" class="img-auto" srcset="">
        </div>
      </div>

    </div>
  </div>

  <div class="container my-6">
    <section class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h2>¿Quiénes somos?</h2>
                    <p class="mt-5">ViajaBara SAS de CV es una empresa de transporte comprometida con brindarte un servicio de calidad en cada uno de tus viajes.</p>
                    <p class="mt-3">Contamos con el mejor servicio del mercado teniendo vans con confort premium, climatizadas y asientos reclinables además de contar con una operación 100% regulada, choferes expertos con licencia federal para garantizar la aeguridad y protección total con nuestro seguro de viajero, nuestras vans están listas para todo y siempre limpias siguiendo protocolos sanitarios.</p>
                    <p class="mt-2">¡También gestionamos envíos de paquetería!</p>
                    <p class="mt-2">ViajaBara es una nueva forma de viajar, ViajaBara te ofrece un transporte rápido, cómodo y seguro. ¡Vive la experiencia de viajar con ViajaBara¡</p>
                </div>
                 <div class="col-12 text-center">
                    
                </div>

            </div>
    </section>
     <hr class="mt-5 mb-2 horizontal dark" />
    <section class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h2 class="mb-5">Ruta Actual</h2>
                    <div class="multisteps-form__progress mb-5">
                        <button
                        class="multisteps-form__progress-btn js-active"
                        type="button"
                        title="User Info"
                        :class="activeStep >= 0 ? activeClass : ''"
                        @click="activeStep = 0" >
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

                     <div class="multisteps-form__progress">
                        <button
                        class="multisteps-form__progress-btn js-active"
                        type="button"
                        title="User Info"
                        :class="activeStep >= 0 ? activeClass : ''"
                        @click="activeStep = 0" >
                        <span class="d-block">Café Yaguar Tlaxcalancing</span>
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
    </section>

  </div>
</template>
<script>
import Navbar from "@/examples/PageLayout/Navbar.vue";
//import PricingCard from "../../../../views/pages/components/PricingCard.vue";
//import AppFooter from "@/examples/PageLayout/Footer.vue";
//import AccordionItem from "../../../../views/pages/components/AccordionItem.vue";
import setNavPills from "@/assets/js/nav-pills.js";
//import Accordion from "../../../../views/pages/components/Accordion.vue";
import icon from "../../../../assets/img/landing-image.png";

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
        icon
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
