<template>
    <div class="login">
        <input type="text" v-model="email" placeholder="Entrer votre Email">
        <input type="password" v-model="password" placeholder="Entrer votre mot de passe">
        <button @click="login">Se connecter</button>
    </div>
</template>

<script>
import axios from 'axios'
export default {
    name: 'Login',
    data(){
        return {
            email: '',
            password: ''
        }
    },
    methods:{
        login(){
            this.$store.dispatch("login", { email: this.email, password: this.password })
            .then(() =>{
                this.$router.push({name: "Home"})
            })
        }
    }
}
</script>

<style>
    .login{
        margin-bottom:50px;
    }
    .login input{
        width: 300px;
        height: 40px;
        padding-left: 20px;
        display: block;
        margin-bottom: 30px;
        margin-right: auto;
        margin-left: auto;
        border: 1px solid lightcoral;
    }
    .login button{
        width: 320px;
        height: 40px;
        border: 1px solid lightcoral;
        background: lightcoral;
        color: white;
        cursor: pointer;
    }
</style>