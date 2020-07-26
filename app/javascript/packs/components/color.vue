<template>
  <div>
    <div class="color-select">
      <form>
        <label for="red" class="red" >{{ colors['red'] }}</label>
        <input type="radio" id="red" value="red" v-model="color">

        <label for="yellow" class="yellow" >{{ colors['yellow'] }}</label>
        <input type="radio" id="yellow" value="yellow" v-model="color">

        <label for="blue" class="blue" >{{ colors['blue'] }}</label>
        <input type="radio" id="blue" value="blue" v-model="color">

        <label for="light-blue" class="light-blue">{{ colors['lightBlue'] }}</label>
        <input type="radio" id="light-blue" value="light-blue" v-model="color">

        <label for="green" class="green" >{{ colors['green'] }}</label>
        <input type="radio" id="green" value="green" v-model="color">

        <label for="yellow-green" class="yellow-green" >{{ colors['yellowGreen'] }}</label>
        <input type="radio" id="yellow-reen" value="yellow-green" v-model="color">

        <label for="white" class="white">その他</label>
        <input type="radio" id="white" value="white" v-model="color">

      </form>
    </div>

    <div  class="color-bind" v-vind:id="color" >現在のペンの色:  {{ color }}</div>



    <router-view v-bind:color="color" v-if='isRouterShow' class="reload"></router-view>
  </div>
</template>

<script>
  import axios from 'axios';
  import Router from '../router/router';
  import Graph from './graph.vue';
  export default {
    components: { Graph },
    provide() {
      return {
        reload: this.reload
      }
    },
    data: function() {
      return {
        color: "white",
        colors:[],
        isRouterShow: true
      };
    },
    mounted() {
       axios
       .get('/api/v1/graphs/color.json')
       .then(response => (this.colors = response.data))



     },
     methods: {
       async reload() {
         this.isRouterShow = false
         await this.$nextTick()
         this.isRouterShow = true
       }
    }
  };

</script>
