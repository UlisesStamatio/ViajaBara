import Operations from "./user.storage";

const OperationsController = {
    async newUser(data){
        const {profile, username, email, name, lastname, surname, cellphone, birthday, sex, state } = data
        const lastData = {
            profile: profile,
            username: username,
            email: email,
            person: {
                name: name,
                surname: `${lastname} ${surname === '' ? '': surname}`,
                cellphone: cellphone,
                birthDate: birthday,
                sex: `${parseInt(sex) === 1 ? 'h' : 'm'}`,
                state:{
                    id: parseInt(state)
                }
            },
            roles:[{
                id: 2
            }] ,

        }

      const response = await Operations.newUser('/register', lastData)
      return response;
    },
    async listUsers(){
        const response = await Operations.lisUsers('/all-drivers')
        return response;
    },
    async listConsumers(){
        const response = await Operations.listConsumers('/all-consumers')
        return response;
    }
}

export default OperationsController;