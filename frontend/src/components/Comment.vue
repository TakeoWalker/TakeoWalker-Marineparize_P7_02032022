<template>
    <div class="commentSection">
        <form class="commentAdded">
            <input type="text" name="body" placeholder="Ecrivez votre commentaire" v-model="comment.body"/>
            <button type="button" @click="addComment"> Publier </button>
        </form>

        <div class="allComments">
            <h4>Tous les commentaires</h4>
            <div v-for="comment in comments" :key="comment.id" class="oneComment">
                    <div class="user_comment">
                <div v-if="comment.user_icon_url !== '../assets/defaultIcon.png'">
                    <img :src="comment.user_icon_url" alt="icon" class="iconUser"/>
                </div>
                <div v-else>
                    <img src="../assets/defaultIcon.png" alt="icon" class="iconUser"/>
                </div>                
                        {{comment.user_username}}
                    </div>
                    <p class="comment_body">{{comment.comment_body}}</p>
                    <p class="comment_create">Publié le {{comment.create_comment_at}}</p>
                    <p v-if="comment.modified_comment_at !== null && comment.modified_comment_at !== 'Invalid date'" class="comment_modify">Modifié le {{comment.modified_comment_at}}</p>
                    <div v-if="comment.user_id == user.id || user.role == 'admin'" class="actionsComment">
                        <button type="button" class="commentDelete" @click="deleteComment(comment.id)">Supprimer</button>
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
    .commentAdded{
        border: 2px solid lightcoral;
        height: 250px;
        border-radius: 25px;
    }
    .commentAdded input{
        margin-top: 10px;
        height: 200px;
        border-radius: 25px;
        width:95%;
        border: 1px solid lightcoral;
    }
    .commentAdded button {
        margin-top: 5px;
        background-color: lightcoral;
        border-radius : 5px;
        border: 1px solid lightcoral;
        color: white;
        padding: 5px;
    }
    .oneComment{
        border: 2px solid lightcoral;
        display: grid;
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 25px;
        grid-template-columns: 1fr 3fr;
        grid-template-rows: 1fr 2fr;
    }
    .commentDelete{
        cursor: pointer;
        background-color: lightcoral;
        color: white;
        border: 1px solid lightcoral;
        padding: 5px;
        border-radius: 5px;
    }
    .actionsComment{
        grid-column: 1;
        grid-row: 3;
    }
    .comment_body{
        grid-column: 2;
        grid-row: 1/4;
    }
</style>