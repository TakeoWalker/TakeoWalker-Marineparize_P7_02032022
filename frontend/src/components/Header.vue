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
                <img :src="this.user.icon_url"/>
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
        top: 6%;
        left: 87%;
        width: 300px;
        margin-left: -150px;
        background-color: lightcoral;
        padding: 0 15px;
        text-align: right;
        border-radius: 5px;
    }
    .profil:before {
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
    .profil>nav>a{
        color: white;
        font-size: 20px;
        display: inherit;
    }
    .notif{
        position: fixed;
        z-index: 999;
        top: 6%;
        left: 78%;
        width: 300px;
        margin-left: -150px;
        background-color: lightcoral;
        padding: 0 15px;
        text-align: center;
        border-radius: 5px;
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
    nav>a>img{
        width:120px;
    }
</style>