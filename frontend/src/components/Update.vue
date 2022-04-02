<template>
    <Teleport to="body">
        <div class="addNewContent">
            <h3>Modifiez votre post !</h3>
            <form class="formModify">
                <input type="text" name="title" placeholder="Mettez un titre" v-model="post.title"/>
                <input type="text" name="body" placeholder="Ecrivez votre post" v-model="post.body"/>
                <button type="button" @click="modifyPost"> Publier </button>
            </form>
        </div>
    </Teleport>
</template>
<script>
import axios from "axios"
export default {
    name: 'Update',
    data(){
        return{
            post :{
                userId:'',
                title: '',
                body:''
            }
        }
    },
    async mounted() {
        const result = await axios.get("http://localhost:3000/posts/" + post_id);
        this.post = result.data;
    }
    /* methods:{
        async modifyPost(){
            console.log(this.post.title, this.post.body);
            const userId = JSON.parse(localStorage.user_info);
           /*  const result = await axios.post("http://localhost:3000/posts/" + post_id, {
                title: this.post.title,
                body: this.post.body
            });
            console.log("result", result.data);
        } 
    }*/
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