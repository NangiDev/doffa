<template>
  <v-app>
    <v-main>
      <Form v-if="isLoggedIn" />
      <Login v-else />
    </v-main>
  </v-app>
</template>

<script>
import Login from "./components/Login";
import Form from "./components/Form";

export default {
  name: "App",

  components: {
    Login,
    Form,
  },

  computed: {
    isLoggedIn() {
      return window.location.hash !== "";
    },
  },
};
</script>
