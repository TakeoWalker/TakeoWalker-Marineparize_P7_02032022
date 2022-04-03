<template>
    <Header />
    <div class="post" :key="this.$route.params.id">
        <div class="user_post" @click="goProfil" >
            <div v-if="userPost.icon_url !== '../assets/defaultIcon.png'">
                <img :src="userPost.icon_url" alt="icon" class="iconUser"/>
            </div>
            <div v-else>
                <img src="../assets/defaultIcon.png" alt="icon" class="iconUser"/>
            </div>                
            {{userPost.username}}
            <p class="post_create">Publié le {{post.create_post_at}}</p>
            <p v-if="post.modified_post_at !== null && post.modified_post_at !== 'Invalid date'" class="post_date_modify">Modifié le {{post.modified_post_at}}</p>
        </div>
        <div v-if="modify==false">
            <div class="full_post">
                <h3 class="post_title">{{post.post_title}}</h3>
                <div class="content-img">
                    <img :src="post.image_url" v-if="post.image_url"/>
                </div>
                <p class="post_body">{{post.post_body}}</p>
            </div>
            <div v-if="post.user_id == user.id || user.role == 'admin'" class="actionsPost">
                <button type="button" @click="modifyPost">Modifier</button>
                <button type="button" @click="deletePost">Supprimer</button>
            </div>
        </div>
        <div v-else >
            <div class="post_modify">
                <input class="post_title_modify" v-model="post.post_title"/>
                <input class="post_body_modify" v-model="post.post_body" />
                <input class="post_file_modify" type="file" @change="upload">
                <div class="actions_modify">
                    <button type="button" @click="updatePost">Publier</button> 
                    <button type="button" @click="modifyPost">Annuler</button> 
                </div>
            </div>
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
            file: null,
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
                this.$router.push({name: "Home"})
            }
        },
        goProfil(){
            this.$router.push("/users/"+ this.userPost.id);
        },
        upload(e){
            this.file = e.target.files[0];
        },
        async updatePost(){
            const formdata = new FormData();
            formdata.append("image", this.file);
            formdata.append(
                "post",
                JSON.stringify({
                    user_id: this.user.id,
                    title: this.post.post_title,
                    body: this.post.post_body,
                    image_url: this.post.image_url
                })
            );
            const result = await axios.put("http://localhost:3000/posts/" + this.$route.params.id, formdata);
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
        background-color: lightcoral ;
        padding: 15px;
        margin-bottom: 20px;
        grid-template-columns: 1fr 3fr;
        grid-template-rows: 1fr auto 1fr;
        grid-gap: 10px;
        align-items: center;
        border: 2px solid lightcoral;
        border-radius: 25px;
    }
    .post_modify{
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .post_title_modify, .post_body_modify{
        width: 92%;
        height: 40px;
        padding-left: 20px;
        display: block;
        margin-bottom: 20px;
        border: 1px solid lightcoral;
    }
    .full_post{
        border: 3px solid beige;
        border-radius: 0 0 25px 25px;
        margin: 20px 0;
    }
    @media screen and (max-width: 750px){
        .post{
            width: 100%;
            padding: 25px 0;
        }
        .content-img img{
            max-height: 500px;
            max-width: 335px;
        }
        .full_post{
            border-bottom: 3px solid beige;
            border-top: 3px solid beige;
            border-right: none;
            border-left: none; 
        }
        .user_post{
            border-right: none !important;
            border-left: none !important;     
        }
    }
    .content-img img{
        max-height: 500px;
    }
    .user_post{
        padding-top: 20px;
        border: 3px solid beige;
        border-radius: 25px 25px 0 0;
    }
    .post_title{
        border-bottom: 1px solid beige;
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
    .post_create, .post_date_modify{
        font-size: 15px;
    }
    .iconUser{
        width: 50px;
        border-radius: 50%;
    }
    .post_file_modify{
        border: 1px solid beige;
        padding: 20px;  
    }
    .actionsPost button, .post_modify button{
        grid-column: 1;
        grid-row: 3;
        width: 100px;
        background-color: beige;
        border: 1px solid beige;
        border-radius: 5px;
        color: black;
        height: 25px;
        margin: 10px;
    }
</style>