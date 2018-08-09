<template>
  <div id="app">
    <flowchart> </flowchart>
  </div>
</template>

<script>
import 'jquery.flowchart/jquery.flowchart.css'
import Flowchart from './Flowchart.vue'
export default {
  components:{
   Flowchart
  },
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
