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
    <div class="wrapper"><p class="timer-setting"> 時間を入力</p><p class="timer-marker-color" v-bind:id="color">ペンの色: {{color}}</p><div class="pen-image"></div></div>
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
        timerId:null,
        id:[]
      };
    },
    mounted: async function() {
       await axios
       .get('/api/v1/timers.json')
       .then(response => (this.timerList = response.data))
       if(this.timerList['stopping']){
         this.min = this.timerList['start_time_min'];
         this.sec = this.timerList['start_time_sec'];
         this.countTime = this.timerList['time'];
         this.timerId =  this.timerList['id'];
         this.timerOn = false;
         this.show = false;
       }else{
       if (this.timerList['start_time_min']){
         this.min = this.timerList['start_time_min'];
         this.sec = this.timerList['start_time_sec'];
         this.countTime = this.timerList['time'];
         this.timerId =  this.timerList['id'];
         var self = this;
         this.timerObj = setInterval(function() {self.count()}, 1000);
         this.timerOn = true;
         this.show = true;

       }else if (this.timerList['fin_timer']) {
          count = this.timerList['time'] / 15;
          color = this.timerList['color'];
          this.timerId = this.timerList['id'];
          this.updateTimer(count,color);
       }else{

       }

     }




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
         if(this.timerId){
           this.updateTimestamp();
         }else{
            this.createTimestamp();
         }
       },


       pause: function() {
         clearInterval(this.timerObj);
         this.timerOn = false;
         this.show = false;
         this.pauseTimeStamp();
       },


       complete: function(dialog) {
         clearInterval(this.timerObj);
          var count = (this.countTime - this.min ) / 15;
         this.updateTimer(count,this.color);

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
         this.updateTimer(count,this.color);
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
       createTimestamp:async function(){


            await axios
            .post('/api/v1/time_stamps.json', {time_stamp:{time_to_calculate:this.countTime,color: this.color}})
            .then((response) => {
                this.resources = response.data;
                this.timerId = this.resources['id'];
            }, (error) => {
              console.log(error);
            });
          },
        updateTimestamp:async function(){


             await axios
             .put(`/api/v1/time_stamps/${this.timerId}.json`, {time_stamp:{start:true}})
             .then((response) => {
                 this.resources = response.data;
                 this.timerId = this.resources['id'];
             }, (error) => {
               console.log(error);
             });
           },
        pauseTimeStamp:async function(){
          await axios
          .put(`/api/v1/time_stamps/${this.timerId}.json`, {time_stamp:{stop:true}})
          .then((response) => {
              this.resources = response.data;
              this.timerId = this.resources['id'];
          }, (error) => {
            console.log(error);
          });
        },

       updateTimer:async function(count,color){


            await axios
            .post('/api/v1/timers.json', {timer:{count:count ,color: color}})
            .then((response) => {
                      this.resources = response.data;
                      this.timerId = this.resources['id'];
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
