<template>
  <div>
    <p class="canvas-tag">直近1ヶ月の勉強時間</p>

     <BarChartDay class="chart" :width="1000" :height="300" :data="charts"></BarChartDay>

    <p class="canvas-tag">直近一年の勉強時間</p>

     <BarChartMonth class="chart" :width="1000" :height="300" v-bind:charts="charts" ></BarChartMonth>

  </div>



</template>

<script>
import VueCharts from 'vue-chartjs'
import axios from 'axios';
var BarChartMonth = {
  extends: VueCharts.Bar,
  data: function() {
    return {
      charts: [],
      data: [],
      labels: []
    };
  },

  mounted: async function() {
    await axios
    .get('/api/v1/charts/month.json')
    .then(response => (this.charts = response.data))
    for (let i= 1; i < 13; i++){
      this.data[i] = this.charts[i];
    }
    for(let i=0;i < 12; i++){
      var date = new Date();
      if ( (date.getMonth() - i + 1) > 0){
        this.labels[11 - i] =  `${date.getFullYear()}年${date.getMonth() - i + 1}月` ;
      }else{
        this.labels[11 - i] = `${date.getFullYear()-1}年${(12 + (date.getMonth() - i + 1))}月`;
      }
    }

    this.renderChart({
      options:{
        maintainAspectRatio: false,
        responsive: false
        },

      labels:  this.labels,
      datasets: [
        {
          type: 'line',
          label: '勉強時間',
          backgroundColor: '#f87979',
          data: this.data
        }
      ]
    })
  }

}
var BarChartDay = {
  extends: VueCharts.Bar,
  data: function() {
    return {
      charts: [],
      data: [],
      labels: []
    };
  },
  mounted: async function() {
    await axios
    .get('/api/v1/charts/day.json')
    .then(response => (this.charts = response.data))

    for (let i= 1; i<31; i++){
      this.data[i-1] = this.charts[i]['time'];
      if (this.charts[i]['day']){
        this.labels[i-1] = this.charts[i]['day'];
      }else{
        this.labels[i-1] = ""
      }
    }

    this.renderChart({
      options:{
        maintainAspectRatio: false,
        responsive: false
    },
      labels: this.labels,
      datasets: [
        {
          type: 'line',
          label: '勉強時間',
          backgroundColor: '#66CCFF',
          data: this.data
        }
      ]
    })
  }

}
export default {
  name: 'Test',

  created : async function() {


   },
  components: {
    BarChartMonth,
    BarChartDay

  }
}

</script>

<style scoped>
  .chart {
    width: 300px;
    height: 300px;
    margin: auto;
    padding: 20px;
  }
</style>
