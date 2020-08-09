<template>
  <div>
  <div v-for="d in timeByField" v-bind:id="d.color"　v-bind:key="d.field">

    <p class="time-by-field-today">{{ d.field }}:{{ d.count }}</p>

  </div>

  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    props: ['id'],
    data: function() {
      return {
        timeByField: [],
    
      };
    },
    mounted: async function() {
       await axios
       .get('/api/v1/time_by_field_todays.json',{
         params: {
           id: this.id

         }

       })
       .then(response => (this.timeByField = response.data))



     },
     methods: {

    }
  };

</script>
