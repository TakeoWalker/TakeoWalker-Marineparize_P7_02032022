import { createStore } from "vuex";
import axios from "axios";

export default createStore({
  state: {
    user: null,
    token: null,
  },
  actions: {
    async login(context, payload) {
      return new Promise((resolve, reject) => {
        axios
          .post("http://localhost:3000/auth/login", payload)
          .then((res) => {
            context.state.user = res.data.user;
            context.state.token = res.data.token;
            localStorage.setItem("token", context.state.token);
            axios.defaults.headers.common[
              "Authorization"
            ] = `Bearer ${context.state.token}`;
            resolve();
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
    init(context) {
      return new Promise((resolve, reject) => {
        axios.defaults.headers.common[
          "Authorization"
        ] = `Bearer ${localStorage.token}`;
        axios.get("http://localhost:3000/auth/me").then((res) => {
          context.state.user = res.data.user;
          context.state.token = localStorage.token;
          localStorage.setItem("token", context.state.token);
          resolve();
        });
      });
    },
  },
  mutations: {
    setUser(state, payload) {
      state.user = payload;
    },
  },
  getters: {
    user(state) {
      return state.user;
    },
  },
});
