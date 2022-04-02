<template>
  <img class="logo" src="../assets/icon-above-font.svg" alt="groupomania logo">
  <h1>Bienvenue sur le réseau social de Groupomania</h1>
  <nav>
      <router-link to="/signup" @click="chooseSignUp" ref="signUp">S'enregistrer</router-link>
      <router-link to="/login" @click="chooseLogin" ref="login">Se connecter</router-link>
  </nav>
  <router-view></router-view>
</template>

<script>
import SignUp from './SignUp.vue'
import Login from './Login.vue'
export default {
  name: 'Register',
  components:{
    SignUp,
    Login
  },
  data(){
    return{
      isShown: true,
    }  
  },
  methods: {
    chooseSignUp(){
      this.isShown = true
    },
    chooseLogin(){
      this.isShown = false
    }
  },
  mounted() {
    let user = localStorage.getItem('user_info');
    if(user){
      this.$router.push({name:'Home'})
    }
  }
}
</script>

<style scope>
  .logo{
    object-fit: cover;
    width: 100%;
    height: 270px;
    max-width: 600px;
    margin-top: 60px;
  }
  nav>a {
    font-size: 1.5em;
    display: inline-block;
    padding-bottom: 10px;
    margin: 20px;
    cursor: pointer;
    text-decoration: none;
    color: lightcoral;
  }
  .router-link-active {
    border-bottom: 1px solid lightcoral;
  }
</style>