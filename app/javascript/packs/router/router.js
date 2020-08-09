import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Graph from '../components/graph.vue'
import Timer from '../components/timer.vue'


Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/studies/:aid(\\d{1,7})', component: Graph },
    { path: '/studies/:aid(\\d{1,7})', component: Timer},


  ],
})
