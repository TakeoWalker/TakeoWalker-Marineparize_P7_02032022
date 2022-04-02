import { createApp } from "vue";
import router from "./routers.js";
import App from "./App.vue";
import store from "./store.js";

createApp(App).use(router).use(store).mount("#app");
