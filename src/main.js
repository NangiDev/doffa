import Vue from "vue";
import App from "./App.vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css"; // Ensure you are using css-loader
import vuetify from "./plugins/vuetify";
import InlineSvg from "vue-inline-svg";

Vue.component("inline-svg", InlineSvg);

Vue.use(Vuetify);

Vue.config.productionTip = false;

new Vue({
  vuetify,
  render: (h) => h(App),
}).$mount("#app");
