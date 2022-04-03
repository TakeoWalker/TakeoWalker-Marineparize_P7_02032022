<template>
    <header>
        <img @click="goHome" class="logoHome" src="../assets/icon-left-font.svg" alt="groupomania logo"/>
        <nav>
            <a @click="toggleNotif"><p>Notification</p></a>
            <Teleport to="body">
                <div v-if="openNotif" class="notif">
                    <nav>
                        <a href="#">Tout</a>
                        <a href="#">Non lu</a>
                        <a href="#">Lu</a>
                    </nav>
                </div>
            </Teleport>
            <a @click="toggleProfil" class="ourIconUser">
                <img class="ourIcon" v-if="user.icon_url !== '../assets/defaultIcon.png'" :src="this.user.icon_url"/>
                <img class="ourIcon" v-else src="../assets/defaultIcon.png"/>
                <p class="header_username">{{user.username}}</p>
            </a>
            <Teleport to="body">
                <div v-if="openProfil" class="profil">
                    <nav>
                        <a @click="goProfil">Voir Profil</a>
                        <a href="#">Paramètre</a>
                        <a @click="logout">Se déconnecter</a>
                    </nav>
                </div>
            </Teleport>
        </nav>
    </header>
</template>
<script>
export default {
    name: 'Header',
    data() {
        return{
            openProfil: false,
            openNotif: false,
        }
    },
    computed:{
        user(){
            return this.$store.getters["user"];
        }
    },
    methods: {
        toggleProfil(){
            this.openProfil = !this.openProfil;
            this.openNotif = false;
            },
        toggleNotif(){
            this.openNotif = !this.openNotif;
            this.openProfil = false;
        },
        logout(){
            localStorage.clear();
            this.$router.push({name:'Login'});
        },
        goHome(){
            return this.$router.push({ name: 'Home'});
        },
        goProfil(){
            this.$router.push("/users/"+ this.user.id);
        }
    }
}
</script>

<style>
    header{
        display: flex;
        justify-content: space-between;
        padding-right: 20px;
    }
    .header_username {
        display: none;
    }

    .logoHome{
        max-width: 400px;
        object-fit: cover;
        height: 5.5em;
        width: 100%;
        cursor: pointer;
    }
    .profil{
        position: fixed;
        z-index: 999;
        top: 145px;
        right: 30px;
        width: auto;
        display: inline-block;
        margin-left: -150px;
        background-color: lightcoral;
        padding: 0 15px;
        text-align: right;
        border-radius: 5px;
        border: 1px solid beige;

    }
    .profil:before {
        content: "";
        position: absolute;
        right: 35%;
        top: -10px;
        width: 0;
        height: 0;
        border-top: 13px solid transparent;
        border-right: 26px solid lightcoral;
        border-bottom: 13px solid transparent;
    }
    .profil>nav>a{
        color: white;
        font-size: 20px;
        display: inherit;
    }
    .notif{
        position: fixed;
        z-index: 999;
        top: 63px;
        right: 195px;
        width: 300px;
        margin-left: -150px;
        background-color: lightcoral;
        padding: 0 15px;
        text-align: center;
        border-radius: 5px;
        border: 1px solid beige;
    }
    .notif:before {
        content: "";
        position: absolute;
        right: 17%;
        top: -10px;
        width: 0;
        height: 0;
        border-top: 13px solid transparent;
        border-right: 26px solid lightcoral;
        border-bottom: 13px solid transparent;
    }
    .notif>nav>a{
        font-size: 20px;
        color: white;
    }
    nav>a>p{
        position: relative;
        bottom: 90px;
    }
    nav>a>img{
        width:120px;
    }
    @media screen and (max-width: 750px){
        header{
            flex-direction: column;
            padding: 0;
            height: 190px;
        }
        .header_username {
            display: block;
        }
        .ourIcon{
            display:none;
        }
        nav>a>p{
            bottom:0;
        }
        header>a {
            padding:0;
        }
        .profil, .notif{
            top:165px;
            text-align: right;
            right: auto;
            width: 100%;
            margin: 0;
            padding: 0;
            display: relative;
        }
        .notif>nav>a{
            display:inherit;
        }
        .notif:before{
            left: 80px;
        }
    }
</style>