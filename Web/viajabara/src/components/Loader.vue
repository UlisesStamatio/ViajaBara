<template>
    <div class="loading-view" v-if="isLoading">
    <!-- Agrega aquí tu indicador de carga, por ejemplo, una animación CSS o una imagen de carga -->
        <div class="loader"></div>
  </div>
</template>

<script>
export default {
    name: "Loader",
    props:{
        isLoading: Boolean,
    },
}
</script>

<style scoped>
.loading-view {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.loader {
  border: 6px solid #f3f3f3;
  border-top: 6px solid #3498db;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

</style>