<template>
    <Header />
    <div v-if="modify==false">
        <div class="post" :key="this.$route.params.id">
            <div class="user_post" @click="goProfil" >
                <img src="../assets/defaultIcon.png" alt="default icon" class="iconUser"/>
                {{userPost.username}}
                <p class="post_create">Publié le {{post.create_post_at}}</p>
            </div>
            <h3 class="post_title">{{post.post_title}}</h3>
            <p class="post_body">{{post.post_body}}</p>
            <p v-if="post.modified_post_at !== null && post.modified_post_at !== 'Invalid date'" class="post_modify">Modifié le {{post.modified_post_at}}</p>
            <div v-if="post.user_id == user.id || user.role == 'admin'" class="actionsPost">
                <button type="button" @click="modifyPost">Modifier</button>
                <button type="button" @click="deletePost">Supprimer</button>
            </div>
        </div>
    </div>
    <div v-else>
        <div class="post" :key="this.$route.params.id">
            <div class="user_post">
                <img src="../assets/defaultIcon.png" alt="default icon" class="iconUser"/>
                {{userPost.username}}
                <p class="post_create">Publié le {{post.create_post_at}}</p>
            </div>
            <input class="post_title" v-model="post.post_title"/>
            <input class="post_body" v-model="post.post_body" />
                <button type="button" @click="updatePost">Publier</button>
        </div>   
    </div>
    <Comment />
</template>

<script>
import Header from "./Header"
import axios from "axios"
import Comment from "./Comment.vue"
import moment from "moment"
export default {
    name: "Post",
    components:{
        Header,
        Comment
    },
    data() {
        return{
            post: [],
            userPost: [],
            modify: false
        }
    },
    computed: {
        user(){
            return this.$store.getters["user"];
        }
    },
    methods: {
        modifyPost(){
            this.modify = !this.modify;            
        },
        async getPost(){
            const result = await axios.get("http://localhost:3000/posts/" + this.$route.params.id);
            const resultUserId = result.data[0].user_id
            const userData = await axios.get("http://localhost:3000/auth/"+ resultUserId)
            this.post = result.data[0];
            this.post.create_post_at = moment(this.post.create_post_at).format('DD-MM-YYYY hh:mm:ss');
            this.post.modified_post_at = moment(this.post.modified_post_at).format('DD-MM-YYYY hh:mm:ss');
            this.userPost = userData.data[0];
        },
        async deletePost(){
            const result = await axios.delete("http://localhost:3000/posts/" + this.$route.params.id);
            if (result.status == 200){
                console.log("Votre post a été supprimé");
                this.post = [];
                this.getPost();
                this.$router.push({name: "Home"})
            }
        },
        goProfil(){
            this.$router.push("/users/"+ this.userPost.id);
        },
        async updatePost(){
            const result = await axios.put("http://localhost:3000/posts/" + this.$route.params.id, {
                title: this.post.post_title,
                body: this.post.post_body
            });
            if (result.status == 201){
                console.log("Votre post a été modifié");
                this.modifyPost();
                this.post = [];
                this.getPost();
            }
        }
    },
    async mounted(){
        this.getPost();
    }
}
</script>
<style>
    .post{
        width: 50%;
        height: 50%;
        display: block;
        margin-left: auto;
        margin-right: auto;
        background-color: white ;
        display: grid;
        padding: 15px;
        margin-bottom: 20px;
        grid-template-columns: 1fr 3fr;
        grid-template-rows: 1fr auto 1fr;
        grid-gap: 10px;
        align-items: center;
        border: 2px solid lightcoral;
        border-radius: 25px;
    }
    .user_post{
        border-right: 1px solid lightcoral;
        border-bottom: 1px solid lightcoral;
    }
    .post_title{
        border-bottom: 1px solid lightcoral;
        padding-bottom: 14px;
        margin-left: 30px;
        margin-right: 30px;
    }
    .post_body{
        grid-column: 2/3;
        grid-row: 2/4;  
        justify-self: baseline;
        align-self: baseline;
        padding: 0 2em; 
    }
    .post_create, .post_modify{
        grid-column: 1;
        grid-row: 2;
    }
    .iconUser{
        width: 50px;
        border-radius: 50%;
    }
    .actionsPost button{
        grid-column: 1;
        grid-row: 3;
        width: 100px;
        background-color: lightcoral;
        border: 1px solid lightcoral;
        border-radius: 5px;
        color: white;
        height: 25px;
        margin: 5px 0;
    }
    .post_create{
        font-size: 15px;
    }
</style>