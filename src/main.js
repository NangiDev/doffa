import Vue from "vue";
import App from "./App.vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css"; // Ensure you are using css-loader
import vuetify from "./plugins/vuetify";
import bulma from "bulma";

Vue.use(Vuetify);

Vue.config.productionTip = false;

new Vue({
  vuetify,
  bulma,
  render: (h) => h(App),
}).$mount("#app");
