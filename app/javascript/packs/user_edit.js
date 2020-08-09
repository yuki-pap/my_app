
import Vue from 'vue/dist/vue.esm';
var app = new Vue({

    el: '#edit',

    data: {
      active: 1
    },

    methods: {
      change: function(num) {
        this.active = num;
      }
    }




});
