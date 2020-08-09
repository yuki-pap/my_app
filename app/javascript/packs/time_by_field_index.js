import Vue from 'vue/dist/vue.esm';

import Today from './components/time-today.vue';

import axios from 'axios';




//const token = document.getElementByName('csrf-token')[0].getAttribute('content')
//axios.dafaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

var app = new Vue({

    el: '#times',


      components:{
        'today': Today,

      }



});
