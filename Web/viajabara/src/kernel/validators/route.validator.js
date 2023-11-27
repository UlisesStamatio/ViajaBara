

const routeValidator = {

   isSameAddress(latStart, latEnd, lngStart, lngEnd){
     if(latStart === latEnd && lngEnd === lngStart) return 'Ingresa diferentes direcciones.'
     return null
   },
   isSameStopOver(stopovers, lat, lng){
    if(stopovers.filter(stopover => stopover.lat === lat && stopover.lng === lng).length > 0) return "La parada ya se ha añadido." ;
    return null;
   },
   validateAddress(address){
    if(!address.lat || !address.lng) return "Ingresa una dirección"
    return null;
   },
   isSameAddressesRegardingEndAndStart(stopovers, addressStart, addressEnd){
    
    if(stopovers.filter((stopover) => addressStart.lat === stopover.lat  && addressStart.lng === stopover.lng).length > 0) return "Hay alguna dirección de parada igual a la dirección de partida"
    if(stopovers.filter((stopover) => addressEnd.lat === stopover.lat  && addressEnd.lng === stopover.lng).length > 0) return "Hay alguna dirección de parada igual a la dirección de llegada"
    return null;
   }

}


export default routeValidator;