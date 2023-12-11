import OperationsController from "../adapters/user.controller";

const pad = (value) => {
    return value < 10 ? '0' + value : value;
}

const getProfile = async(id) =>{
    const payload = {
        id: parseInt(id)
    }
    const response = await OperationsController.getProfile(payload)
    const {error} = response
    if(!error){
        const {data:{result:{profile, person:{name, surname, sex, birthDate, cellphone, state, id}, username, email}}} = response;
        let date = new Date(birthDate);
        let year = date.getUTCFullYear();
        let month = date.getUTCMonth() + 1; // Los meses en JavaScript van de 0 a 11
        let day = date.getUTCDate();
        let hours = date.getUTCHours();
        let minutes = date.getUTCMinutes();
        let seconds = date.getUTCSeconds();

        let formattedDate = year + '-' + pad(month) + '-' + pad(day) + 'T' + pad(hours) + ':' + pad(minutes) + ':' + pad(seconds) + 'Z';
        response.data.result = {
            id: id,
            profile: profile,
            name: name,
            lastname: surname.split(' ')[0],
            surname: surname.split(' ').length > 1 ? surname.split(' ')[1] : '', 
            sex: sex === 'H' ? 1 : 2,
            birthday: formattedDate.split('T')[0],
            cellphone: parseInt(cellphone),
            username: username,
            email: email,
            confirmEmail: email,
            state: state ? state.id : '',
        }
    }
    return response;
}


export default getProfile;