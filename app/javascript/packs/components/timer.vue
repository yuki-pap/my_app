<template>
<div>
  <div class="study-time-wrapper">
    <div class="study-times">
        <p>本日の勉強時間</p>
      <div class="box">
        <p class="yajirushi">&#9758;</p> <div class="study-time">{{ timerList['today']}}</div>
      </div>
    </div>
    <div class="study-times">
          <p>今月の総勉強時間</p>
       <div class="box">
          <p class="yajirushi">&#9758;</p> <div class="study-time">{{ timerList['month'] }}</div>
       </div>
    </div>


    <div class="study-times">
      <p>今までの総勉強時間</p>
      <div class="box">
        <p class="yajirushi">&#9758;</p> <div class="study-time">{{ timerList['all'] }}</div>
      </div>
    </div>
  </div>



  <div class="timer-wrapper">
    <p class="timer-title">Timer</p>
    <div class="wrapper"><p class="timer-setting"> 時間を入力</p><p v-bind:id="color">ペンの色: {{color}}</p><div class="pen-image"></div></div>
    <div class="timer-class-wrapper" v-if="!timerOn && show"><input type="text"  v-model="min" class="timer-form" v-on:change="minUpdate" />分</div>
    <div class="timer">
      {{ formatTime }}
    </div>

    <button class="start" v-on:click="start" v-if="!timerOn">Start</button>
    <button class="pause" v-on:click="pause" v-if="timerOn">一時停止</button>
    <button class="stop" v-confirm="openDialog()" v-if="timerOn">停止</button>

  </div>

</div>
</template>

<script>
  import axios from 'axios';

  export default {
    props: ['color'],
    data: function() {
      return {
        min: 15,
        sec: 0,
        countTime:15,
        timerList: [],
        responses:[],
        timerOn: false,
        show: true,
        timerObj:null,
      };
    },
    mounted: async function() {
       await axios
       .get('/api/v1/timers.json')
       .then(response => (this.timerList = response.data))



     },
     methods: {
       openDialog: function() {
         var self = this;
         return {
           loader: true,
           ok: function(dialog){self.complete(dialog)},
           cancel: function(dialog){self.doNothing(dialog)},
           backdropClose: true,
           okText: 'Ok',
           cancelText: 'キャンセル',
           message: {
             title: '確認',
             body: `タイマーを停止しますか？`
           }
         };

       },
       minUpdate: function(){
         this.countTime = this.min;
       },
       count: function() {
         if (this.sec <= 0 && this.min >= 1) {
           this.min --;
           this.sec = 59;
         } else if(this.sec <= 0 && this.min <= 0) {
           this.countComplete();
         } else {
           this.sec --;
        }
      },

       start: function() {
         var self = this;
         this.timerObj = setInterval(function() {self.count()}, 1000);
         this.timerOn = true;
         this.show = true;
       },


       pause: function() {
         clearInterval(this.timerObj);
         this.timerOn = false;
         this.show = false;
         //timerがOFFであることを状態として保持
       },


       complete: function(dialog) {
         clearInterval(this.timerObj);
          var count = (this.countTime - this.min ) / 15;
         this.updateTimer(3);

         this.timerOn = false;
         this.show = true;
         this.min = 15;
         this.sec = 0;
         setTimeout(function() {
           dialog.close();
         }, 2);

       },
       countComplete: function(){
         var count = this.countTime / 15;
         this.updateTimer(count);
         clearInterval(this.timerObj);
         this.timerOn = false;
         this.show = true;
         this.min = 15;
         this.sec = 0;
       },

       doNothing: function(dialog){

         setTimeout(function() {
           dialog.close();
         }, 2);
       },

       updateTimer:async function(count){


            await axios
            .post('/api/v1/timers.json', {timer:{count:count ,color: this.color}})
            .then((response) => {
                      this.resources = response.data;
            }, (error) => {
              console.log(error);
            });




        }
    },
    computed: {
    formatTime: function() {
      let timeStrings = [
          this.min.toString(),
          this.sec.toString()
        ].map(function(str) {
          if (str.length < 2) {
            return "0" + str
            } else {
              return str
            }
          })
          return timeStrings[0] + ":" + timeStrings[1]
        }
      }
  }


</script>
