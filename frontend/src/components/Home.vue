<template>
    <Header />
    <Add @addPost="createPost()"/>
    <div id="posts">
        <div v-for="post in posts" :key="post.id" class="onePosts">
            <div class="user_posts" @click="goProfil(post.user_id)">
                <div v-if="post.user_icon_url !== '../assets/defaultIcon.png'" class="class_Icon">
                    <img :src="post.user_icon_url" alt="icon" class="icon_User"/>
                </div>
                <div v-else class="class_Icon">
                    <img src="../assets/defaultIcon.png" alt="icon" class="icon_User"/>
                </div>
                <div>
                    <h3>{{post.user_username}}</h3>
                    <p class="posts_create" >Créé le {{post.create_post_at}}</p>
                    <p v-if="post.modified_post_at !== null && post.modified_post_at !== 'Invalid date'" class="posts_modify">Modifié le {{post.modified_post_at}}</p>
                </div>
            </div>
            <div class="fullPosts">
                <router-link :to="'/posts/' + post.id">
                    <h3 class="posts_title">{{post.post_title}}</h3>
                    <div v-if="post.image_url !== null || post.image_url !== undefined">
                        <img :src="post.image_url" class="img_posts"/>
                    </div>
                    <p class="posts_body">{{post.post_body}}</p>
                </router-link>
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
                    result.user_icon_url = resultUser.data[0].icon_url;
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
    .user_posts{
        cursor: pointer;
        grid-column: 1/4;
        border: 3px solid beige;
        border-radius: 25px 25px 0 0;
        width: 100%;
        margin-bottom: 20px;
    }
    .onePosts{
        background-color: lightcoral;
        display: flex;
        padding: 15px;
        margin: 135px 0;
        align-items: center;
        border: 2px solid lightcoral;
        border-radius: 25px;
        flex-direction: column;
    }
    .posts_title{
        border-bottom: 1px solid beige;
        padding-bottom: 14px;
        margin-left: 30px;
        margin-right: 30px;
    }
    .posts_body{
        grid-column: 2/3;
        grid-row: 2/4;  
        justify-self: baseline;
        align-self: baseline;
        padding: 0 2em; 
    }
    .posts_create, .posts_modify{
        grid-column: 1;
        grid-row: 2;
    }
    .icon_User{
        width: 150px;
        border-radius: 50%;
        margin-bottom: 20px;
    }
    #posts a{
        text-decoration: none;
        color: black;
    }
    .img_posts{
        max-width: 340px;
    }
    .fullPosts{
        grid-column: 1/4;
        grid-row: 2/4;
        border: 3px solid beige;
        border-radius: 0 0 25px 25px;
        width: 100%;
    }
    .class_Icon{
        height: 40px;
        position: relative;
        bottom: 100px;
    }
    @media screen and (max-width: 750px){
        #posts{
            width: 100%;
        }
    }
</style>