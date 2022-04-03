<template>
    <Header />
    <div v-if="userProfil.icon_url !== '../assets/defaultIcon.png'">
        <img :src="userProfil.icon_url" alt="icon" class="iconUser"/>
    </div>
    <div v-else>
        <img src="../assets/defaultIcon.png" alt="default icon" class="iconUser"/>
    </div>

    <h3 class="username">{{userProfil.username}}</h3>
    <p>Ce compte a été créé le {{this.userProfil.created_on}}</p>
    <p>Ce compte est un {{userProfil.role}}</p>
    <div v-if="userProfil.id == user.id || user.role == 'admin'" class="actionsProfil">
        <button type="button" @click="modifyProfil">Modifier votre profil</button>
        <button type="button" @click="deleteProfil">Supprimer votre profil</button>
    </div>

    <div v-show="modify == true" class="profilToChange">
        <div v-if="userProfil.icon_url !== '../assets/defaultIcon.png'">
            <img :src="userProfil.icon_url" alt="icon" class="iconUser"/>
        </div>
        <div v-else class>
            <img src="../assets/defaultIcon.png" alt="default icon" class="iconUser"/>
        </div>

        <input type="file" id="icon" name="icon" ref="icon" @change="upload"/>
        <div class="preview">
            <p>{{ messageImage }}</p>
        </div>
        <div class="infoTochange">
            <input type="text" v-model="userProfil.username" />
            <input type="email" v-model="userProfil.email" />
        </div>
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
            messageImage: "Aucun fichier sélectionné pour le moment",
            icon: null
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
            if(this.user.id === this.userProfil.id){
                this.$store.commit("setUser", this.userProfil);
            }
        },
        modifyProfil(){
            this.modify = !this.modify;
        },
        async updateProfil(){  
            const formdata = new FormData();
            if(this.icon){
                formdata.append("image", this.icon);
            }
            formdata.append(
                "user",
                JSON.stringify({
                    username: this.userProfil.username,
                    email: this.userProfil.email
                })
            );
            console.log(formdata);

            const result = await axios.put("http://localhost:3000/auth/" + this.$route.params.id, formdata);

            if (result.status == 201){
                console.log("Votre post a été modifié");
                this.modifyProfil();
                this.profil = [];
                this.getUser();
            }
        },
        async deleteProfil(){
            console.log(this.userProfil.icon_url);
            const result = await axios.delete("http://localhost:3000/auth/" + this.$route.params.id);
            if(result.status == 200){
                console.log("Ce compte a été supprimé");
                this.$router.push({name: "Login"})
            } 
        },
        upload(event){
            this.icon = event.target.files[0];
            this.messageImage = "Vous venez de choisir " + this.$refs.icon.files[0].name;     
    },
    },
    mounted(){
        this.getUser();
    }
}
</script>
<style>
    .actionsProfil button{
        background-color: lightcoral;
        color: white;
        border: 1px solid lightcoral;
        padding: 5px;
        margin: 10px;
        border-radius: 5px;
        cursor: pointer;
    }
    .profilToChange button{
        background-color: beige;
        border: 1px solid beige;
        padding: 5px;
        margin: 10px;
        border-radius: 5px;
        cursor: pointer;
    }
    .username{
        color: lightcoral;
        font-size: 30px;
    }
    #icon{
        border: 1px solid beige;
        padding: 10px;
        color: beige;
    }
    .iconUser{
        width: 150px;
    }
    .infoTochange input{
        margin-right: 20px;
        margin-bottom: 20px;
        width: 200px;
        height: 20px;
        background-color: beige;
        border: 1px solid beige;
        padding-left: 10px;
    }
    .profilToChange{
        background-color: lightcoral;
        padding: 20px;
        width: 50%;
        margin: 25px auto;
        border-radius: 25px;
    }
    @media screen and (max-width: 750px){
        .profilToChange{ 
            width: auto;
            margin-bottom: 0;
            padding-bottom: 100px;
            border-radius: 25px 25px 0 0;
        }
        .actionsProfil{
            margin-bottom: 100px;
    }
    }
</style>