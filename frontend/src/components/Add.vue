<template>
    <div class="addNewContent">
        <h3>Rédigez un post !</h3>
        <form class="addForm">
            <input type="text" name="title" placeholder="Mettez un titre" v-model="post.title"/>
            <input type="text" name="body" placeholder="Ecrivez votre post" v-model="post.body"/>
            <input type="file" @change="upload" />
            <button type="button" @click="addPost"> Publier </button>
        </form>
    </div>
</template>
<script>
import axios from "axios"
export default {
    name: 'Add',
    data(){
        return{
            post :{
                userId:'',
                title: '',
                body:''
            },
            file: null
        }
    },
    computed:{
        user(){
            return this.$store.getters["user"]
        }
    },
    methods:{
        async addPost(){
            const formdata = new FormData();
            if(this.file){
                formdata.append("image", this.file);
            }
            formdata.append(
                "post",
                JSON.stringify({
                    user_id: this.user.id,
                    title: this.post.title,
                    body: this.post.body
                })
            );
            console.log(formdata)
            const result = await axios.post("http://localhost:3000/posts", formdata);
            if (result.status == 201){
                console.log("Votre post a été créé");
                this.$emit("addPost")
            }
        },
        upload(event){
            this.file = event.target.files[0];

        }
    }
}
</script>

<style>
    .addNewContent{
        width: 45%;
        height: 50%;
        display: block;
        margin-left: auto;
        margin-right: auto;
        margin-bottom: 20px;
        background-color: lightcoral;
        padding: 20px;
        border-radius: 2%;
    }
    .addForm input{
        width: 92%;
        height: 40px;
        padding-left: 20px;
        display: block;
        margin-bottom: 20px;
        margin-right: auto;
        margin-left: auto;
        border: 1px solid lightcoral;
    }
    .addForm button{
        width: 100%;
        height: 40px;
        border: 1px solid lightcoral;
        background: lightblue;
        cursor: pointer;
        padding: 0 20px;
    }
</style>