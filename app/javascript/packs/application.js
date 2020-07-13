/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)




//study_controllerの後始末
//linux

//シート交換時の処理
//マーカー 変更時の処理




import Vue from 'vue/dist/vue.esm';
import Router from './router/router';
import Graph from './components/graph.vue';
import Color from './components/color.vue';
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
    el: '#hello',


      components:{
        'navbar': Graph,
        'color': Color,

      }



});
