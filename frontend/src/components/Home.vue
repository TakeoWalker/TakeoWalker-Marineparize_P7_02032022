<template>
    <Header />
    <Add @addPost="createPost()"/>
    <div id="posts">
        <div v-for="post in posts" :key="post.id" class="onePost">
            <div class="user_post" @click="goProfil(post.user_id)">
                <img src="../assets/defaultIcon.png" alt="default icon" class="iconUser"/>
                {{post.user_username}}
                <p class="post_create" >Créé le {{post.create_post_at}}</p>
                <p v-if="post.modified_post_at !== null && post.modified_post_at !== 'Invalid date'" class="post_modify">Modifié le {{post.modified_post_at}}</p>
            </div>
            <router-link :to="'/posts/' + post.id">
                <h3 class="post_title">{{post.post_title}}</h3>
                <p class="post_body">{{post.post_body}}</p>
            </router-link>
            <div v-if="post.user_id == user.id || user.role == 'admin'" class="actionsPost">
                <button type="button" @click="deletePost(post.id)">Supprimer</button>
            </div>
        </div>
    </div>
</template>
<script>
import Header from './Header'
import Add from './Add'
import axios from "axios"
import moment from "moment"

export default {
    name: 'Home',
    components: {
        Header,
        Add
    },
    data(){
        return {
            posts: [],
            userPosts:{}
        }
    },
    computed:{
        user(){
            return this.$store.getters["user"];
        }
    },
    methods:{
        createPost(){
            this.posts = [];
            this.getPost()
        },
        async getPost(){
            let resultsData = await axios.get("http://localhost:3000/posts");
            let results = resultsData.data;
            results.forEach(async result => {
                result.create_post_at = moment(result.create_post_at).format('DD-MM-YYYY hh:mm:ss');
                result.modified_post_at = moment(result.modified_post_at).format('DD-MM-YYYY hh:mm:ss');
                let resultUser = await axios.get("http://localhost:3000/auth/"+ result.user_id);
                result.user_username = resultUser.data[0].username;
                this.posts.push(result);
            });
        },
        goProfil(user_id){
            this.$router.push("/users/"+ user_id);
        },
        async deletePost(postId){
            const result = await axios.delete("http://localhost:3000/posts/" + postId);
            if (result.status == 200){
                console.log("Votre post a été supprimé");
                this.posts = [];
                this.getPost();
            }
            
        }
    },
    async mounted() {
        this.posts = [];
        this.getPost()
    }
  }
</script>
<style>
    #posts{
        width: 50%;
        height: 50%;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }
    .user_post{
        cursor: pointer;
    }
    .onePost{
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
        cursor: pointer;
    }
    #posts a{
        text-decoration: none;
        color: black;
    }
</style>