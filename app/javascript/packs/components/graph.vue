<template>
 <div>
  <div class="study-time-wrapper">
    <div class="study-times">
        <p>本日の勉強時間</p>
      <div class="box">
        <p class="yajirushi">&#9758;</p> <div class="study-time">{{ graphs['today']}}</div>
      </div>
    </div>
    <div class="study-times">
          <p>今月の総勉強時間</p>
       <div class="box">
          <p class="yajirushi">&#9758;</p> <div class="study-time">{{ graphs['month'] }}</div>
       </div>
    </div>


    <div class="study-times">
      <p>今までの総勉強時間</p>
      <div class="box">
        <p class="yajirushi">&#9758;</p> <div class="study-time">{{ graphs['all'] }}</div>
      </div>
    </div>
  </div>

  <p class="vue-flash" id="error" >{{ graphs['error'] }}</p>
  <p class="graph-fill" v-if="this.count == 200" v-on:click="scroll();">現在のシートは100%埋まっています。新しいシートに交換してください。</p>





    <div class="nurie_table" id='html2canvas_img' ref="abc">
      <table ref="abc">
        <tr v-for="count in counts" >
          <td v-for="d in counts"  v-confirm="openDialog((count*10)+d+1)"  v-bind:data-id="(count*10)+d+1"  v-bind:id="graphs[(count*10)+d+1].color" >{{ graphs[(count*10)+d+1].field }}</td>
        </tr>

        <tr v-for="count in counts"  >
          <td v-for="d in counts" v-confirm="openDialog((count*10)+d+100+1)" v-bind:data-id="(count*10)+d+101" v-bind:id="graphs[(count*10)+d+101].color">{{ graphs[(count*10)+d+101].field }}</td>
        </tr>
      </table>
    </div>

    <btn class="new-sheet"  v-confirm="dialog()" ref="sheet">シートを新しくする。&#8658;</btn>





  </div>




</template>
<script>
  import html2canvas from 'html2canvas';
  import axios from 'axios';
  export default {
  inject: ['reload'],
  props: [ 'color' ],
  data: function () {
    return {
    id: 0,
    counts: [0,1,2,3,4,5,6,7,8,9],
    config:{},
    num: 0,
    data: 0,
    graphs: [],
    graph: [],
    show: false,
    judge: 0,
    pictures:[],
    canvasImage: "",
    count:0





   }

  },
  watch:{
    graphs: function(){

    },
    deep: true
  },

 mounted : async function() {
    await axios
    .get('/api/v1/graphs.json')
    .then(response => (this.graphs = response.data))

    for(let i = 1; i < 201; i++){
      if(this.graphs[i].fill){
      this.count += 1;
      }
    }




  },




  methods: {
    openDialog: function(id){

        let self = this;
        if(!(this.graphs[id].fill)){
          if(this.graphs['today'] == "24時間"){
            return {

              loader: true,
              ok: function(dialog){self.doNothing(dialog)},
              cancel: function(dialog){self.doNothing(dialog)},
              backdropClose: true,
              okText: 'Ok',
              cancelText: 'キャンセル',
              message: {
                title: '警告',
                body: `1日は24時間までです！少し休みましょう。`
              }
            };

          }

          else{

            return {

              loader: true,
              ok: function(dialog){self.updateGraph(id,dialog)},
              cancel: function(dialog){self.doNothing(dialog)},
              backdropClose: true,
              okText: 'Ok',
              cancelText: 'キャンセル',
              message: {
                title: '確認',
                body: `1マス塗り潰します。`
              }
            };
          }




        }

        else{

          if(this.graphs['today'] == "0時間"){
            return {

              loader: true,
              ok: function(dialog){self.doNothing(dialog)},
              cancel: function(dialog){self.doNothing(dialog)},
              backdropClose: true,
              okText: 'Ok',
              cancelText: 'キャンセル',
              message: {
                title: '警告',
                body: `本日はまだ学習していません。`
              }
            };

          }


          return {
            loader: true,
            ok: function(dialog){self.deleteGraph(id,dialog)},
            cancel: function(dialog){self.doNothing(dialog)},
            backdropClose: true,
            okText: 'Ok',
            cancelText: 'キャンセル',
            message: {
              title: '確認',
              body: `${this.graphs[id]['field']}のマスを1マス削除します。`
              }
            };

        }
  },
  doNothing:function(dialog){
    setTimeout(function() {
      dialog.close();
    }, 2);
  },


   updateGraph:async function(id,dialog){


        await axios
        .post('/api/v1/graphs.json', {graph:{id:id ,color: this.color}})
        .then((response) => {
                  this.graphs = response.data;
        }, (error) => {
          console.log(error);
        });

        this.reload();


        setTimeout(function() {
          dialog.close();
        }, 2);








    },


   deleteGraph: async function(id,dialog){


      await axios
      .post('/api/v1/graphs.json', {graph:{id:id}})
      .then((response) => {

                this.graphs = response.data;

      }, (error) => {
        console.log(error);
      });






      setTimeout(function() {
        dialog.close();
      }, 2);

      this.reload();





   },

   dialog: function(){
     let self = this;
     return {

       loader: true,
       ok: function(dialog){self.making(dialog)},
       cancel: function(dialog){self.doNothing(dialog)},
       backdropClose: true,
       okText: 'Ok',
       cancelText: 'キャンセル',
       message: {
         title: '確認',
         body: `シートを新しくしてもよろしいですか？現在のシートは保存され変更できなくなります。`
       }
     };

   },

  making: function(dialog){
    window.scrollTo(50, 30);

    html2canvas(this.$refs.abc,{
      height:700,
      windowWidth: 1445,
      windowHeight:1000,
      width:999
    }).then(canvas => {
        const canvasImage = canvas.toDataURL("image/jpeg");
        this.updatePicture(canvasImage,dialog);

        });




   },

    updatePicture: async function(image,dialog){


       await axios
       .post('/api/v1/histories.json', {history:{picture: image}})
       .then((response) => {
          this.graphs = response.data;


       }, (error) => {
         console.log(error);
       });






       setTimeout(function() {
         dialog.close();
       }, 2)

       this.reload();



    },
    scroll: function(){
      window.scrollTo(0, 700);
      this.$refs.sheet.style.color = "red";
    }







  }

}


</script>
