import Operations from "./user.storage";
import moment from 'moment'
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
                birthDate: birthday ? moment(new Date(birthday)).format('YYYY-MM-DD') : null,
                sex: `${parseInt(sex) === 1 ? 'h' : parseInt(sex) === 2 ? 'm' : ''}`,
                state:  state ? { id: parseInt(state)} : null
            },
            roles:[{
                id: 2
            }] ,

        }

      const response = await Operations.newUser('/', lastData)
      return response;
    },
    async updateUser(data){
        const {profile, username, email, name, lastname, surname, cellphone, birthday, sex, state, id } = data
        const lastData = {
            id: id,
            profile: profile,
            username: username,
            email: email,
            person: {
                name: name,
                surname: `${lastname} ${surname === '' ? '': surname}`,
                cellphone: cellphone,
                birthDate:  birthday ? moment(new Date(birthday)).format('YYYY-MM-DD') : null,
                sex: `${parseInt(sex) === 1 ? 'h' : parseInt(sex) === 2 ? 'm' : ''}`,
                state: state ? { id: parseInt(state)} : null
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
    async listDriversEnabled(){
        const response = await Operations.lisUsers('/all-drivers-enabled')
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
    async getProfile(payload){
        const response = await Operations.getUser('/one', payload)
        return response;
    },
    async changeStatusUser(payload){
        const response = await Operations.changeStatusUser('/change-status', payload)
        return response;
    }
}

export default OperationsController;