<template>
    <div class="signUp">
        <input type="text" v-model="username" placeholder="Entrer un pseudo">
        <input type="text" v-model="email" placeholder="Entrer votre Email">
        <input type="password" v-model="password" placeholder="Entrer votre mot de passe">
        <button @click="signUp">S'enregistrer</button>
    </div>
</template>
<script>
import axios from 'axios'
export default {
    name: 'SignUp',
    data(){
        return {
            username: '',
            email: '',
            password: ''
        }
    },
    methods:{
        async signUp() {
            let result = await axios.post("http://localhost:3000/auth/signup", {
                username: this.username,
                email: this.email,
                password: this.password
            });
            if(result.status == 201){
                this.$store.dispatch("login", { email: this.email, password: this.password })
                .then(() =>{
                    this.$router.push({name: "Home"})
                })
            }
            
        }
    }
}
</script>
<style>
    .signUp{
        margin-bottom:50px;
    }
    .signUp input{
        width: 300px;
        height: 40px;
        padding-left: 20px;
        display: block;
        margin-bottom: 30px;
        margin-right: auto;
        margin-left: auto;
        border: 1px solid lightcoral;
    }
    .signUp button{
        width: 320px;
        height: 40px;
        border: 1px solid lightcoral;
        background: lightcoral;
        color: white;
        cursor: pointer;
    }
</style>