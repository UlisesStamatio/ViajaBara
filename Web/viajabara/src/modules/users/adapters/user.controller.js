import Operations from "./user.storage";

const OperationsController = {
    async newUser(data){
        const {profile, username, email, name, lastname, surname, cellphone, birthday, sex, } = data
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
                    id: 1
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
    }
}

export default OperationsController;