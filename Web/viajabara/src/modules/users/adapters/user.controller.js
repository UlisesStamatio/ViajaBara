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
    async updateUser(data){
        const {profile, username, email, name, lastname, surname, cellphone, birthday, sex, state, id } = data
        console.log(id);
        const lastData = {
            id: id,
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

      const response = await Operations.updateUser('/', lastData)
      return response;
    },
    async listUsers(){
        const response = await Operations.lisUsers('/all-drivers')
        return response;
    },
    async listConsumers(){
        const response = await Operations.listConsumers('/all-consumers')
        return response;
    },
    async getUser(payload){
        const response = await Operations.getUser('/one', payload)
        return response;
    },
    async changeStatusUser(payload){
        const response = await Operations.changeStatusUser('/change-status', payload)
        return response;
    }
}

export default OperationsController;