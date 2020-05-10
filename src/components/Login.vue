<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12">
        <v-img
          :src="require('../assets/logo.svg')"
          class="my-3"
          contain
          height="200"
        />
      </v-col>

      <v-col class="mb-4">
        <h1 class="display-2 font-weight-bold mb-3">
          Welcome to Doffa
        </h1>
      </v-col>

      <v-col
        class="mb-5"
        cols="12"
      >
        <h2 class="headline font-weight-bold mb-3">
          Please login to the platform of your choise
        </h2>

        <v-row justify="center">
          <v-btn
            v-for="(next, i) in platforms"
            :key="i"
            :href="next.href"
            class="subheading my-3 col-lg-1"
          >
            {{ next.text }}
          </v-btn>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: 'Login',

    data: () => ({
      platforms: [
        {
          text: 'Fitbit',
          href: 'https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=22BQ88&redirect_uri=https%3A%2F%2Fnangidev.github.io%2Fdoffa%2F&scope=weight&expires_in=604800',
        },
        {
          text: 'Localhost',
          href: 'https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=22BQ88&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Findex.html&scope=weight&expires_in=604800',
        },
      ],
    }),
  }
</script>
