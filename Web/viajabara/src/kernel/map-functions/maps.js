const mapFunctions = {
    async getAddressByLatLng(latLng){
        console.log(latLng);
      let geocoder = new window.google.maps.Geocoder();
        return new Promise((resolve, reject) =>{
            geocoder.geocode({ location: latLng }, (results, status) => {
                if (status === "OK") {
                  if (results[0]) {
                    resolve(results[0].formatted_address);
                  } else {
                    reject("No se encontraron resultados de geocodificación.")
                  }
                } else {
                   reject("Ocurrio un error")
                }
              });
        })
    },
    async getCurrentPosition(){
        return new Promise((resolve, reject)=>{
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                 (position) => {
                    resolve(position)
                 },
                 (error) => {
                    reject("Error getting geolocation: ", error.message)
                 }
               );
               // Geolocation is supported
             } else {
                 reject("Geolocation is not supported by this browser.")
             }
        })
    },
    async convertLatLng(lat, lng){
        console.log(lat, lng);
        return new Promise((resolve, reject) =>{
            try{
                console.log(window);
                //var latlng = window.google.maps.LatLng(lat, lng);
                resolve('Hola')
            }catch(err){
                reject(err)
            }
        })
    }
}

export default mapFunctions;