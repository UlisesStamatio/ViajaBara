


const mapFunctions = {
    async getAddressByLatLng(latLng){
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
                   reject("Ocurrió un error")
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
        return new Promise( (resolve, reject) =>{
            try{
                let latlng = new window.google.maps.LatLng(lat, lng)
                resolve(latlng)
            }catch(err){
                reject(err)
            }
        })
    },
     isPlaceInMexico(result){
      return this.getCountryFromResult(result).includes('México');
    },
    async getGeocode(latLng){
      let geocoder = new window.google.maps.Geocoder();
      return new Promise((resolve, reject) =>{
          geocoder.geocode({ location: latLng }, (results, status) => {
              if (status === "OK") {
                if (results[0]) {
                  resolve(results[0]);
                } else {
                  reject("No se encontraron resultados de geocodificación.")
                }
              } else {
                 reject("Ocurrió un error")
              }
            });
      })
  },
  getStateFromResult(result){
    const {address_components} = result;
    let state = '';
    address_components.forEach(component => {
      const {types, long_name} = component
      types.forEach(type =>{
        if(type.includes('administrative_area_level_1')){
          if(long_name === 'State of Mexico'){
            state = 'Estado de México'
          }else{
            state = long_name;
          }
        }
      })
    });
    return state;
  },

  getCountryFromResult(result){
    const {address_components} = result;
    let country = '';
    address_components.forEach(component => {
      const {types, long_name} = component
      types.forEach(type =>{
        if(type.includes('country')){
          country =  long_name;
        }
      })
    });
    return country;
  },
  async getMetersBetweenTwoDirections(addressStart,addressEnd){
    let directionsService = new window.google.maps.DirectionsService();
    let request = {
      origin: addressStart,
      destination: addressEnd,
      travelMode: 'DRIVING'
  };

    return new Promise((resolve, reject)=>{
      directionsService.route(request, (response, status) => {
        if (status == 'OK') {
            let distanciaEnMetros = (response.routes[0].legs[0].distance.value).toFixed(2);
            resolve(distanciaEnMetros)
        } else {
            reject('No se pudo calcular la distancia debido a: ' + status)
        }
    });
    })
  },

  async getTimeBetweenTwoDirections(addressStart, addressEnd ){
    let directionsService = new window.google.maps.DistanceMatrixService();
    let request = {
      origins: [addressStart],
      destinations: [addressEnd],
      travelMode: 'DRIVING'
    };

    return new Promise((resolve, reject)=>{
      directionsService.getDistanceMatrix(request, (response, status) => {
        if (status == 'OK') {
            const duration = Math.round((response.rows[0].elements[0].duration.value / 60));
            resolve(duration)
        } else {
            reject('No se pudo calcular la distancia debido a: ' + status)
        }
      });
    })

  },
  async getRouteWithPaths(waypoints, addressStart, addressEnd ){
    let directionsService = new window.google.maps.DirectionsService();
    var request = {
        origin: addressStart,
        destination: addressEnd,
        waypoints: waypoints,
        travelMode: 'DRIVING'
    };
    const {route} = directionsService
    return new Promise((resolve, reject)=>{
      route(request, (response, status) => {
        if (status == 'OK') {
            resolve(response)
        } else {
            reject('No se pudo calcular la distancia debido a: ' + status)
        }
      });
    })

  }
}

export default mapFunctions;