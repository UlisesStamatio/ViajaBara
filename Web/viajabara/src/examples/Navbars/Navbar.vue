<template>
  <nav
    id="navbarBlur"
    class="shadow-none navbar navbar-main navbar-expand-lg border-radius-xl"
    :class="[isRTL ? 'top-1 position-sticky z-index-sticky' : '']"
    v-bind="$attrs"
    data-scroll="true"
  >
    <div class="px-3 py-1 container-fluid">
      <breadcrumbs
        :current-directory="currentDirectory"
        :current-page="currentRouteName"
        :text-white="textWhite"
      />
      <div
        class="sidenav-toggler sidenav-toggler-inner d-xl-block d-none"
        :class="isRTL ? 'me-3' : ''"
      >
        <a href="#" class="p-0 nav-link text-body" @click.prevent="minNav">
          <div class="sidenav-toggler-inner">
            <i
              class="sidenav-toggler-line"
              :class="textWhite ? 'bg-white' : ''"
            ></i>
            <i
              class="sidenav-toggler-line"
              :class="textWhite ? 'bg-white' : ''"
            ></i>
            <i
              class="sidenav-toggler-line"
              :class="textWhite ? 'bg-white' : ''"
            ></i>
          </div>
        </a>
      </div>
      <div
        id="navbar"
        class="mt-2 collapse navbar-collapse mt-sm-0 me-md-0 me-sm-4"
        :class="isRTL ? 'px-0' : 'me-sm-4'"
      >
        <div
          class="pe-md-3 d-flex align-items-center"
          :class="isRTL ? 'me-md-auto' : 'ms-md-auto'"
        >
         
        </div>

        <ul class="navbar-nav justify-content-end">

          <div class="btn-group dropstart">
            <a  data-bs-toggle="dropdown" aria-expanded="false" >
              <img
                    alt="Image placeholder"
                    id="image-profile"
                    class="avatar avatar-sm rounded-circle me-2"
                    style="cursor:pointer;"
                    />
            </a>
            <ul class="dropdown-menu">
               <li class="dropdown-item disabled text-dark" disabled>{{name}}</li>
                <li><hr class="dropdown-divider"></li>
              <li class="dropdown-item font-weight-bold" @click="goProfile">
                Perfil
              </li>
              <li class="dropdown-item" @click="logout">Cerrar sesión</li>
            </ul>
          </div>

          
          <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
              <a
                id="iconNavbarSidenav"
                href="#"
                class="p-0 nav-link text-body"
                @click="toggleSidebar"
              >
                <div class="sidenav-toggler-inner">
                  <i class="sidenav-toggler-line"></i>
                  <i class="sidenav-toggler-line"></i>
                  <i class="sidenav-toggler-line"></i>
                </div>
              </a>
            </li>
          


        </ul>
      </div>
    </div>
  </nav>
</template>
<script>
import Breadcrumbs from "../Breadcrumbs.vue";
import { mapMutations, mapActions, mapState } from "vuex";
import router from '../../router/index';
import storeSession from '../../kernel/store/store.session';
import getProfile from '../../modules/users/use-cases/get.profile'
export default {
  name: "Navbar",
  components: {
    Breadcrumbs,
  },
  props: {
    minNav: {
      type: Function,
      default: () => {},
    },
    textWhite: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      showMenu: false,
      user: {},
      name: "",
    };
  },
  computed: {
    ...mapState(["isRTL"]),
    currentRouteName() {
      return this.$route.name;
    },
    currentDirectory() {
      let dir = this.$route.path.split("/")[1];
      return dir.charAt(0).toUpperCase() + dir.slice(1);
    },
  },
  created() {
    this.minNav;
  },
  async mounted(){
    const token = storeSession.getToken();
    if(token){
      await this.getProfile()
    }
  },
  methods: {
    ...mapMutations(["navbarMinimize", "toggleConfigurator"]),
    ...mapActions(["toggleSidebarColor"]),

    toggleSidebar() {
      this.toggleSidebarColor("bg-white");
      this.navbarMinimize();
    },
    logout(){
      storeSession.deleteToken()
      storeSession.deleteDataSession()
      router.push({name: "Signin Illustration"})
    },
    async getProfile(){
      console.log("Entro en el getProfile");
      let {identKey}  = storeSession.getDataSession()
      const response = {...await getProfile(identKey)};
      const {error, data} = response;
        if(!error){
           const {result:{profile, name, surname, lastname}} = data
           const {result} = data
           document.getElementById("image-profile").src = `data:image/png;base64,${profile}`;
           this.user = result;
           this.name = `${name} ${lastname} ${surname}`
      }else{
           this.$swal({
            icon: "error", 
            title: 'Ocurrio un error durante la consultar. Inténtalo de nuevo.',
            type: "basic",
          });
      }
    },
    goProfile(){
      router.push({name: 'Perfil Usuario'})
    }
  },
};
</script>
