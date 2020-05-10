<template>
  <div class="login">
    <h1>{{ title }}</h1>
    <p>{{ msg }}</p>
    <v-btn></v-btn>
    <p>
      <a
        href="https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=22BQ88&redirect_uri=https%3A%2F%2Fnangidev.github.io%2Fdoffa%2F&scope=weight&expires_in=604800"
      >Sign in on Fitbit</a>
      <br />
      <a
        href="https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=22BQ88&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Findex.html&scope=weight&expires_in=604800"
      >Sign in Locally</a>
    </p>
  </div>
</template>

<script>
export default {
  name: "Login",
  props: {
    title: String,
    msg: String,
    items: Array
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
