<template>
  <div class="time-by-fields-index">
  <div v-for="d in timeByField" v-bind:key="d.field" class="time-by-field">
    <div v-bind:id="d.color"></div>
    <p class="time-by-field-today">{{ d.field }}:  {{ d.count }}</p>

  </div>

  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        timeByField: []
      };
    },
    mounted: async function() {
       await axios
       .get('/api/v1/time_by_fields.json')
       .then(response => (this.timeByField = response.data))



     },
     methods: {

    }
  };

</script>
