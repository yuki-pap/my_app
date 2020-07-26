import Vue from 'vue/dist/vue.esm';
import Router from './router/router';
import History from './components/history.vue';
import Chart from './components/chart.vue';

import VuejsDialog from 'vuejs-dialog';
import VuejsDialogMixin from 'vuejs-dialog/dist/vuejs-dialog-mixin.min.js';
import 'vuejs-dialog/dist/vuejs-dialog.min.css';
Vue.use(VuejsDialog);
import axios from 'axios';




//const token = document.getElementByName('csrf-token')[0].getAttribute('content')
//axios.dafaults.headers.common['X-CSRF-Token'] = token
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

var app = new Vue({
   router: Router,
    el: '#histories',


      components:{
        'history': History,
        'chart': Chart,

      }



});
