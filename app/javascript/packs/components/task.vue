<template>
  <div>
    <div class="title-wrapper">
      <h1 class="tasks-title">To-do-List</h1>
      <div class="tasks-flash" v-if="message">
        &#10004;  　　タスクを登録しました！
      </div>
    </div>
    <div class="tasks-wrapper" >
      <TaskForm v-for="d in count" v-bind:number="d" v-on:delete="reload" v-on:update="flash" v-bind:key="tasks[d]['id']"></TaskForm>
    </div>
    <div class="plus-btn" v-on:click="CreateTasks()">
    </div>
  </div>
</template>

<script>
import axios from 'axios';
var TaskForm = {
　template: `<div class="tasks">
              <div class="cross"  v-confirm="openDialog(this.tasks[this.number]['id'])" ></div>
              <input v-on:change="TaskUpdate" type="text" class="task-form" v-model="this.content" type="text" style="width:200px;height:50px;">
              <div v-if="complete"><p class="complete">完了済み</p><p v-on:click="ChangeStarColor(id,false)" class="complete-star">★</p></div>
              <div v-if="!(complete)"><p class="non-complete">完了する</p><p v-on:click="ChangeStarColor(id,true)" class="star">&#10025;</p></div>
            </div>`,
  props:[ 'number' ],
  data: function() {
    return {
      tasks: [],
      content: "",
      id: 0,
      complete:false,


    };
  },

  mounted:  async function() {
    await axios
    .get('/api/v1/tasks.json')
    .then(response => (this.tasks = response.data))

    this.content = this.tasks[this.number]['content'];
    this.id = this.tasks[this.number]['id'];
    this.complete = this.tasks[this.number]['complete'];

  },

  methods:{
    DeleteTask: async function(id,dialog){
      await axios
      .delete(`/api/v1/tasks/${id}.json`)
      .then(response => (this.tasks = response.data))
      setTimeout(function() {
        dialog.close();
      }, 2);
      this.$emit('delete',Number(this.number));
      this.content = this.tasks[this.number]['content'];
      this.id = this.tasks[this.number]['id'];
      this.complete = this.tasks[this.number]['complete'];



    },
    ChangeStarColor:async function(id,complete){
      await axios
      .put(`/api/v1/tasks/${id}.json`, {task:{complete: complete }})
      .then((response) => {
         this.tasks = response.data;


      }, (error) => {
        console.log(error);
      });
      this.content = this.tasks[this.number]['content'];
      this.id = this.tasks[this.number]['id'];
      this.complete = this.tasks[this.number]['complete'];

    },
    TaskUpdate: async function(event){
      await axios
      .put(`/api/v1/tasks/${this.id}.json`, {task:{content: event.target.value }})
      .then((response) => {
         this.tasks = response.data;


      }, (error) => {
        console.log(error);
      });
      this.content = this.tasks[this.number]['content'];
      this.id = this.tasks[this.number]['id'];
      this.complete = this.tasks[this.number]['complete'];
      this.$emit('update','this.content');

    },
    openDialog:  function(id){
      let self = this;
      return {
        loader: true,
        ok: function(dialog){self.DeleteTask(id,dialog)},
        cancel: function(dialog){self.doNothing(dialog)},
        backdropClose: true,
        okText: 'Ok',
        cancelText: 'キャンセル',
        message: {
          title: '確認',
          body: `タスクを削除してよろしいですか？`
        }
      };
    },
    doNothing:function(dialog){
      setTimeout(function() {
        dialog.close();
      }, 2);
    }
  }
}


export default {
data: function () {
  return {

    tasks: [],
    count: [],
    show: true,
    message: false,

  }

  },
  mounted:  async function() {
    await axios
    .get('/api/v1/tasks.json')
    .then(response => (this.tasks = response.data))

  　var data = new Array(this.tasks['size']);
    for(let i=0; i < this.tasks['size']; i++){
      data[i] =  i + 1 ;
    }

    this.count = data;

  },
  components: {
    TaskForm,


  },
  methods:{
    CreateTasks: async function(){
      await axios
      .post('/api/v1/tasks.json')
      .then((response) => {
         this.tasks = response.data;


      }, (error) => {
        console.log(error);
      });
      var data = new Array(this.tasks['size']);
        for(let i=0; i < this.tasks['size']; i++){
          data[i] =  i + 1 ;
        }

        this.count = data;

    },
    flash: function(e){
      this.message = true;
      setTimeout(() => {
        this.message = false}
        ,4000
      )
    },

    reload: async function(e) {
      await axios
      .get('/api/v1/tasks.json')
      .then(response => (this.tasks = response.data))
      var data = new Array(this.tasks['size']);
        for(let i=0; i < this.tasks['size']; i++){
          data[i] =  i + 1 ;
        }


        this.count = data;
    }



  }




}
</script>
