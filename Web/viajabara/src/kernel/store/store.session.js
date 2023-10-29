
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
    }
}


export default storeSession;