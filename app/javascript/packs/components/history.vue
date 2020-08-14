<template>
  <div class="garary-wrapper">
    <div class="garary">
      <div class="triangle-left" v-on:click="back()"></div>
      <p class="current-number">{{currentNumber}}枚目<p>
      <div class="img">


        <img v-bind:src="histories[currentNumber].url"/>

      </div>


      <div class="triangle-right" v-on:click="forword()"></div>
    </div>
    <div class="imformation">
      <p>日時: {{histories[this.currentNumber].create}}</p>
      <p>空白:{{histories[this.currentNumber].percent}}%</p>
      <a v-bind:href="histories[currentNumber].url" download="nurie.png" class="download-link">画像を保存</a>
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

created: async function(){
  await axios
  .get('/api/v1/histories.json')
  .then(response => (this.histories = response.data))

  this.currentNumber = Object.keys(this.histories).length - 1;
},
mounted:function() {



},

methods: {
  back: function(){
    if (!(this.currentNumber == 1)){
      this.currentNumber -= 1;


    }
  },
  forword: function(){
    if (!(Object.keys(this.histories).length == this.currentNumber)){
    this.currentNumber += 1;


      }
    }

  }

}




</script>
