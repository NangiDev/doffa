<template>
  <v-container>
    <v-col class="text-center">
      <v-img
        :src="require('../assets/logo.png')"
        class="m-6"
        contain
        height="200"
      />
      <h1 class="text-h1">Welcome to Doffa</h1>
      <h2 class="text-h6 m-6">
        Please login to the platform of your choise
      </h2>
      <v-btn
        x-large
        color="primary"
        rounded
        elevation="3"
        class="m-2"
        v-for="(next, i) in platforms"
        :key="i"
        :href="next.href"
        >{{ next.text }}
      </v-btn>
    </v-col>
  </v-container>
</template>

<script>
export default {
  name: "Login",

  data: () => ({
    platforms: [
      {
        text: "Fitbit",
        href:
          "https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=22BQ88&redirect_uri=https%3A%2F%2Fnangidev.github.io%2Fdoffa%2F&scope=weight&expires_in=604800",
      },
    ],
  }),
};
</script>
