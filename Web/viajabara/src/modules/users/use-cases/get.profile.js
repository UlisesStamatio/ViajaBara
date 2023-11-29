import OperationsController from "../adapters/user.controller";

const getProfile = async(id) =>{
    const payload = {
        id: parseInt(id)
    }
    const response = await OperationsController.getProfile(payload)
    const {error} = response
    if(!error){
        const {data:{result:{profile, person:{name, surname, sex, birthDate, cellphone, state}, username, email}}} = response;
        response.data.result = {
            profile: profile,
            name: name,
            lastname: surname.split(' ')[0],
            surname: surname.split(' ').length > 1 ? surname.split(' ')[1] : '', 
            sex: sex === 'H' ? 1 : 2,
            birthday: new Date(birthDate).toISOString().split('T')[0],
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