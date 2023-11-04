
const storeSession = {
    setToken(token){
        localStorage.setItem('session', JSON.stringify(token))
    },
    getToken(){
        let token = localStorage.getItem('session')
        token = JSON.parse(token)
        return token;
    },
    deleteToken(){
        localStorage.removeItem("session")
    },

    setDataSession(data){
        localStorage.setItem('data', JSON.stringify(data))
    },
    getDataSession(){
        let data = localStorage.getItem('data')
        data = JSON.parse(data)
        return data;
    },
    deleteDataSession(){
        localStorage.removeItem("data")
    }
}


export default storeSession;