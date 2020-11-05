<template>
  <v-container fill-height>
    <v-col align="center" justify="center">
      <inline-svg
        height="200px"
        width="200px"
        :src="require('../assets/prism.svg')"
      />
      <div id="login_anim">
        <div class="headline text-h1 mb-10 font-weight-medium">
          DOFFA
        </div>
        <div class="instructions text-h5 mb-14">
          Choose your platform
        </div>
        <v-btn
          min-width="200px"
          class="text-h6 mb-10 white--text"
          color="#4288f5"
          elevation="2"
          rounded
          x-large
          v-for="(next, i) in platforms"
          :key="i"
          :href="next.href"
          >{{ next.text }}
        </v-btn>
      </div>
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
