<template>
    <Header />
    <img src="../assets/defaultIcon.png" alt="default icon" class="iconUser"/>
    {{userProfil.username}}
    <p>Ce compte a été créé le {{this.userProfil.created_on}}</p>
    <p>Ce compte est un {{userProfil.role}}</p>
    <div v-if="userProfil.id == user.id || user.role == 'admin'" class="actionsProfil">
        <button type="button" @click="modifyProfil">Modifier votre profil</button>
        <button type="button" @click="deleteProfil">Supprimer votre profil</button>
    </div>

    <div v-show="modify == true">
        <img src="../assets/defaultIcon.png" alt="default icon" class="iconUser"/>
        <input type="file" ref="icon">
        <input type="text" v-model="userProfil.username" />
        <input type="email" v-model="userProfil.email" />
        <button type="button" @click="updateProfil">Mettre à jour</button>
    </div>
</template>
<script>
import Header from "./Header.vue"
import moment from "moment"
import axios from "axios"
export default {
    name: 'Profil',
    data(){
        return{
            userProfil: {},
            modify: false,
            imageUrl: undefined,
        }
    },
    computed:{
        user(){
            return this.$store.getters["user"];
        }
    },
    components:{
        Header,
    },
    methods:{
        async getUser(){
            const result = await axios.get("http://localhost:3000/auth/" + this.$route.params.id)
            this.userProfil = result.data[0];
            this.userProfil.created_on = moment(this.userProfil.created_on).format('DD-MM-YYYY hh:mm:ss');
        },
        modifyProfil(){
            this.modify = !this.modify;
        },
        async updateProfil(){
            console.log(this.imageUrl);
            const result = await axios.put("http://localhost:3000/auth/" + this.$route.params.id, {
                imageUrl: this.imageUrl, 
                username: this.userProfil.username,
                email: this.userProfil.email,
            });
            if (result.status == 201){
                console.log("Votre post a été modifié");
                this.modifyProfil();
                this.profil = [];
                this.getUser();
            }
        },
        async deleteProfil(){
            console.log("Ce compte va être supprimé");
            const result = await axios.delete("http://localhost:3000/auth/" + this.$route.params.id)
            if(result.status == 200){
                console.log("Ce compte a été supprimé");
                this.$router.push({name: "Login"})
            } 
        },
        onFileChange(){
            console.log(this.$refs.icon[0]);
            this.imageUrl = this.$refs.icon[0];
        }
    },
    mounted(){
        this.getUser();
    }
}
</script>
<style>

</style>