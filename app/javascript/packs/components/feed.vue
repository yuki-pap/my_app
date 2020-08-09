<template>
  <div>
<div class="feeds-wrapper">
  <div v-for="feed in feeds" v-bind:key="feed.id" class="feeds-box">
    <p class="feed-name">{{ feed.name }}</p>
  <div class="feeds">
     <div class="feeds-dairy">
       <p class="feed-dairy">今日の日記</p>
       <p class="feed-description">{{ feed.description }}</p>
     </div>

    <div class="feed-time-today-wrpper">
       <p class="feed-time-title">本日の勉強時間</p>
       <div v-for="d in feed" class="feed-time-today">
         <p class="time-by-field-today" v-bind:id="d.color">{{ d.field }} {{ d.count }}</p>
       </div>
    </div>
  </div>
  </div>
</div>
  <div class="scroll-wrapper" v-on:click="scrollTop()" >
  <div class="scroll-icon"></div><p class="scroll">ページトップへ戻る</p>
</div>
</div>
</template>

<script>
  import axios from 'axios';

  export default {

    data: function() {
      return {
        feeds: [],

      };
    },
    mounted: async function() {
       await axios
       .get('/api/v1/feeds.json')
       .then(response => (this.feeds = response.data))



     },
     methods: {
       scrollTop: function(){
        window.scrollTo(0, 0);
       }

    }
  };

</script>
