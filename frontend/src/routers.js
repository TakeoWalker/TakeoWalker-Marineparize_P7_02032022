import { createRouter, createWebHistory } from "vue-router";
import Home from "./components/Home.vue";
import SignUp from "./components/SignUp.vue";
import Login from "./components/Login.vue";
import Register from "./components/Register.vue";
import Post from "./components/Post.vue";
import Profil from "./components/Profil.vue";
import store from "./store.js";

const routes = [
  {
    name: "Home",
    component: Home,
    path: "/",
  },
  {
    name: "Post",
    component: Post,
    path: "/posts/:id",
  },
  {
    name: "Profil",
    component: Profil,
    path: "/users/:id",
  },
  {
    name: "Register",
    component: Register,
    path: "/register",
    children: [
      {
        name: "SignUp",
        component: SignUp,
        path: "/signup",
      },
      {
        name: "Login",
        component: Login,
        path: "/login",
      },
      {
        path: "",
        redirect: () => "/register/login",
      },
    ],
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});
router.beforeEach((to, from, next) => {
  const user = store.getters["user"];
  if (user == null && to.name !== "Login" && to.name !== "SignUp") {
    next({ name: "Login" });
  } else {
    next();
  }
});

export default router;
