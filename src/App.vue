<template>
  <div id="app">
    <h1>Daily Reporting Form for Class 4 Supervision</h1>
    <TitleForm />
  </div>
</template>

<script>
import TitleForm from './components/TitleForm.vue'

export default {
  name: 'App',
  components: {
    TitleForm
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Dancing+Script&display=swap');

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.comments {
  white-space: pre;
}
</style>
