<template>
<Loader :isLoading="isLoading"/>
  <div class="py-4 container-fluid">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <!-- Card header -->
          <div class="pb-0 card-header">
            <h5>Detalle de la ruta</h5>
          </div>
          <div class="px-0 pb-0 card-body mx-4 my-2">
            <div class="row">
              <div class="col">
               <GMapMap
              :center="center"
              ref="myMapRef"
              :zoom="zoom"
              style="height: 40rem"
               :options="mapOptions" 
               >
              </GMapMap>
              </div>
              <div class="col-12 text-start text-lg-end mt-4">
                <button
                class="btn bg-gradient-dark"
                title="Regresar"
                @click="regresar()"
                >Regresar</button>
              </div>
            </div>


          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
//import { DataTable } from "simple-datatables";
import setTooltip from "@/assets/js/tooltip.js";
import Loader from '../../../../components/Loader.vue'
import getRoute from '../../use-cases/get.route'
import mapFunctions from '../../../../kernel/map-functions/maps'
import router from '../../../../router/index'

export default {
  name: "DetailRoute",
  components:{
    Loader,
  },
  data(){
    return{
      routes:[],
      datatable: null,
      isLoading: false,
      idRoute: 0,
      route: {},
      zoom: 12,
      center: {lat:23.634501, lng: -102.552784},
      mapOptions: {
        disableDefaultUI: true, 
      },
      map:{}
    }
  },
  async mounted() {
      this.idRoute = this.$route.params.id;
      await this.getRoute(this.idRoute)
      await this.getRouteWithPaths()
      setTooltip(this.$store.state.bootstrap);
  },

  methods:{
      async getRoute(id){
      this.isLoading = true;
      const response = {...await getRoute(id)};
      const {error, data} = response;
      this.isLoading = false;
      if(!error){
          const {result} = data
          this.route = result;
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },

    async getRouteWithPaths(){
      
      //let map = new window.google.maps.Map(document.getElementById('map'), {zoom: this.zoom, center: this.route.startAddress.description});
      this.$refs.myMapRef.$mapPromise.then(async (mapObject) => {

          const waypoints = this.route.stopOvers.map((stopover, array) => {
            if (stopover.sequence !== 1 && stopover.sequence !== array.length) {
              return {location: stopover.address.description, stopover: true };
            }
            return undefined;
          }).filter(element => element !== undefined);

        const response = await mapFunctions.getRouteWithPaths(waypoints, this.route.stopOvers[0].address.description, this.route.stopOvers[(this.route.stopOvers.length -1)].address.description);
        let directionsRenderer = new window.google.maps.DirectionsRenderer();
        directionsRenderer.setMap(mapObject);
        directionsRenderer.setDirections(response);
      });
    },
    regresar(){
      router.push({name: 'Consultar Rutas'})
    }
  }
};
</script>
