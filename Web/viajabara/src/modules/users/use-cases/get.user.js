import OperationsController from "../adapters/user.controller";

const getUser = async(id) =>{
    const payload = {
        id: parseInt(id)
    }
    const response = await OperationsController.getUser(payload)
    const {error} = response
    if(!error){
        const {data:{result:{profile, person:{name, surname, sex, birthDate, cellphone, state:{id}}, username, email}}} = response;
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
            state: id,
        }
    }
    console.log(response);
    return response;
}


export default getUser;