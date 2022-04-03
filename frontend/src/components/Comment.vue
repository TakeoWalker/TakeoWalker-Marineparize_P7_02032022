<template>
    <div class="commentSection">
        <form class="commentAdded">
            <textarea rows="10" cols="50" name="body" placeholder="Ecrivez votre commentaire" v-model="comment.body"/>
            <button type="button" @click="addComment"> Publier </button>
        </form>

        <div class="allComments">
            <h4>Tous les commentaires</h4>
            <div v-for="comment in comments" :key="comment.id" class="oneComment">
                <div class="user_comment">
                    <div v-if="comment.user_icon_url !== '../assets/defaultIcon.png'">
                        <img :src="comment.user_icon_url" alt="icon" class="iconUser iconUserComment"/>
                    </div>
                    <div v-else>
                        <img src="../assets/defaultIcon.png" alt="icon" class="iconUser iconUserComment"/>
                    </div>
                    <div class="user_other">
                        {{comment.user_username}}
                        <p class="comment_create">Publié le {{comment.create_comment_at}}</p>
                        <p v-if="comment.modified_comment_at !== null && comment.modified_comment_at !== 'Invalid date'" class="comment_modify">Modifié le {{comment.modified_comment_at}}</p>
                        <div v-if="comment.user_id == user.id || user.role == 'admin'" class="actionsComment">
                            <button type="button" class="commentDelete" @click="deleteComment(comment.id)">Supprimer</button>
                        </div>
                    </div>             
                </div>
                <div>
                    <p class="comment_body">{{comment.comment_body}}</p>   
                </div>
            </div>   
        </div>    
    </div>

</template>
<script>
import axios from "axios"
import moment from "moment"
export default {
    name: 'Comment',
    data(){
        return{
            comment : {
                body:''
            },
            comments :[],
        }
    },
    computed:{
        user(){
            return this.$store.getters["user"]
        }
    },
    methods:{
        async addComment(){
            const result = await axios.post("http://localhost:3000/comments", {
                user_id: this.user.id,
                post_id: this.$route.params.id,
                body: this.comment.body
            });
            if (result.status == 201){
                console.log("Commentaire ajouté");
                this.comments = [];
                this.getComment();
            }
        },
        createComment(){
            this.getComment()
        },
        async getComment(){
            let resultsData = await axios.get("http://localhost:3000/comments");
            let results = resultsData.data;
            results.forEach(async result => {
                if(result.post_id == this.$route.params.id){
                    result.create_comment_at = moment(result.create_comment_at).format('DD-MM-YYYY hh:mm:ss');
                    result.modified_comment_at = moment(result.modified_comment_at).format('DD-MM-YYYY hh:mm:ss');
                    let resultUser = await axios.get("http://localhost:3000/auth/"+ result.user_id);
                    result.user_username = resultUser.data[0].username;
                    result.user_icon_url = resultUser.data[0].icon_url;
                    this.comments.push(result);
                }
            });
        },
        async deleteComment(id){
            console.log("Ce commentaire va être supprimé");
            const result = await axios.delete("http://localhost:3000/comments/" + id);
            if (result.status == 200){
                console.log("Votre commentaire a été supprimé");
                this.comments = [];
                this.getComment(); 
            }
        }
    },
    async mounted() {
        this.getComment();
    }
}
</script>

<style>
    .commentSection{
        width: 50%;
        height: 50%;
        margin-left: auto;
        margin-right: auto;
        margin-bottom: 20px;
    }
    .allComments{
        margin-top: 30px;
        border-top: 8px solid lightcoral;
        border-radius: 20px;    
    }
    @media screen and (max-width: 750px){
        .commentSection{
            width: 100%;
        }
        .user_comment{
            display: flex;
            align-items: center;
            border-bottom: 1px solid lightcoral;
            padding-bottom: 5px;
        }
        .iconUserComment {
            margin-right: 20px;
        }
        .oneComment{
            display: flex;
            flex-direction: column;
            border-right: none !important;
            border-left: none !important;
        }
        .allComments{
            width: 100%;
        }
        .commentAdded textarea {
            padding: 14px !important;  
        }
    }
    .commentAdded{
        height: 250px;
        border-radius: 25px;
    }
    .commentAdded textarea{
        padding: 20px;
        margin-top: 10px;
        height: 150px;
        border-radius: 25px;
        width:90%;
        border: 3px solid lightcoral;
        font-family: Arial, Helvetica, sans-serif;
    }
    .commentAdded button {
        margin-top: 5px;
        background-color: lightcoral;
        border-radius : 5px;
        border: 1px solid lightcoral;
        color: white;
        padding: 15px;
    }
    .oneComment{
        border: 2px solid lightcoral;
        display: flex;
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 25px;
    }
    .commentDelete{
        cursor: pointer;
        background-color: lightcoral;
        color: white;
        border: 1px solid lightcoral;
        padding: 5px;
        border-radius: 5px;
    }
    .comment_body{
        padding: 20px;
    }
</style>