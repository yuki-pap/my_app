<template>
  <div class="garary-wrapper">
    <div class="garary">
      <div class="triangle-left" v-on:click="back()"></div>
      <p class="current-number">{{currentNumber}}枚目<p>
      <div class="img">

        <img ref="myimage"/>

      </div>


      <div class="triangle-right" v-on:click="forword()"></div>
    </div>
    <div class="imformation">
      <p>日時: {{histories[this.currentNumber].create}}</p>
      <p>空白:{{histories[this.currentNumber].percent}}%</p>
    </div>
  </div>



</template>

<script>
import axios from 'axios';
export default {
inject: ['reload'],
props: [ 'color' ],
data: function () {
  return {
  histories: [],
  currentNumber:1,




 }

},


mounted: async function() {
  await axios
  .get('/api/v1/histories.json')
  .then(response => (this.histories = response.data))


  this.$refs.myimage.src = this.histories[this.currentNumber].url;


},

methods: {
  back: function(){
    if (!(this.currentNumber == 1)){
      this.currentNumber -= 1;
      this.$refs.myimage.src = this.histories[this.currentNumber].url;

    }
  },
  forword: function(){
    if (!(Object.keys(this.histories).length == this.currentNumber)){
    this.currentNumber += 1;
    this.$refs.myimage.src = this.histories[this.currentNumber].url;

      }
    }

  }

}




</script>
