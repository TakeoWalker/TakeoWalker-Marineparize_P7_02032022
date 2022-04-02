<template>
    <router-view />
</template>

<script>
export default {
  name: 'App',
  mounted() {
    if (localStorage.token){
      this.$store.dispatch("init").then(() => {
        this.$router.push({ name: "Home" })
      })
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /*margin-top: 60px;*/
}
body{
  margin: 0;
  padding: 0;
}
</style>
