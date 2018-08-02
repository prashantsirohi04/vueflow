<template>
  <div class="container" refs="container">
  <div class="card" title="" header-tag="header" footer-tag="footer">
      <div class="card-header">
      <div class="col-md-4">
        <select  class="form-control" v-model="selecteddoc" text="Flowchart" @change="clear()">
         <option :value="null"></option>
          <option v-for="(doc,index) in total_doc" :value="doc" v-bind:key="index">{{doc}}</option>
        </select>
      </div>
      <div class="col-md-8">
        <div class="buttonTopRight">
        <b-button variant="white" v-on:click="saveData" class="savebtn"> Save As Recipe </b-button>
        <div id="select-components">
          <div id="flows-dropdown" class="dropdown fright" style="display:inline-block; margin-right:14px;">
                <button  class="btn btn-default dropdown-toggle flows-dropdown-btn transparent-button" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background:#fff; margin-left:7px; border:solid 1px #c4c4c4; border-radius:3px !important;">
                   Add
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <div class="dropdown-item" v-for="(comp, index) in components" @click="setcomponent(comp)" :key="index" style="cursor: pointer;">
                       <img :src="getImage(comp)" class="icon"> {{comp}}</div>
                </div>
            </div>
            <add-operator @add-operator="createOperator" :name="currentComponent" :show="show" @close="close()"></add-operator>
       </div>
        <b-button variant="primary" v-on:click="getData" class="create_operator pull-right"> Run </b-button>
        </div>
       </div>
  </div>
       <div id="chart">
      </div>
    </div>
  </div>
</template>

<script>
import 'jquery.flowchart/jquery.flowchart.css'
import 'jquery-ui-dist/jquery-ui.css'
import 'jquery-ui-dist/jquery-ui.js'
import {DATATBASE} from '../../config/firebase_con.js'
import AddOperator from './AddOperator'
window.$ = window.jQuery = require('jquery')
require('jquery-ui-dist/jquery-ui')
require('jquery.flowchart/jquery.flowchart.js')
var db = DATATBASE
export default {
  name: 'HelloWorld',
  components: {
    AddOperator
  },
  data () {
    return {
      show: false,
      data: '',
      count: 0,
      total_doc: [],
      selecteddoc: 'null',
      components: ['DataTask', 'Train', 'Deploy'],
      currentComponent: ''
    }
  },
  mounted: function () {
    this.getcollections()
    var self = this
    setTimeout(() => {
      var flowchart = $('#chart')
      flowchart.flowchart({
        data: this.data,
        distanceFromArrow: 2,
        defaultLinkColor: '#c6c4c5',
        multipleLinksOnOutput: true,
        multipleLinksOnInput: true,
        linkWidth: 2
      })
    }, 500)
    $('#selectcomponent').selectmenu({
      change: function (event, ui) {
        self.currentComponent = ui.item.value
        self.show = true
      }
    })
  },
  computed: {
    currentTabComponent: function () {
      return this.currentComponent.toLowerCase()
    },
    reload: function () {
      return this.selecteddoc
    }
  },
  methods: {
    setcomponent (cmp) {
      this.currentComponent = cmp
      this.show = true
    },
    getImage (cmp) {
      var images = require.context('../assets/', false, /\.png$/)
      return images('./' + cmp + '.png')
    },
    close () {
      this.show = false
      this.currentComponent = ''
    },
    clear () {
      if (this.selecteddoc == null) {
        location.reload()
      }
    },
    createOperator (opData) {
      this.count += 1
      var operatorI = this.count
      var flowchart = $('#chart')
      var operatorId = 'created_operator_' + operatorI
      flowchart.flowchart('createOperator', operatorId, opData)
      this.currentComponent = ''
      this.show = false
    },
    saveData () {
      var data = $('#chart').flowchart('getData')
      // console.log(this.selecteddoc==null)
      var self = this
      if (this.selecteddoc !== 'null' && this.selecteddoc !== null) {
        db.collection('flowchart').doc(this.selecteddoc).set({
          data: data
        })
      }
      else {
        alert(123)
        db.collection('flowchart').add({
          data: data
        }).then(function (docRef) {
          self.total_doc.push(docRef.id)
          alert('saved:' + docRef.id)
          self.selecteddoc = docRef.id
        })
      }
      this.refresh = true
    },
    getcollections () {
      var self = this
      db.collection('flowchart').get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
          self.total_doc.push(doc.id)
        })
      })
    },
    getData (todo) {
      var self = this
      db.collection('flowchart').doc(this.selecteddoc).get().then(function (doc) {
        if (doc.data() !== undefined) {
          self.data = doc.data().data
          self.count = Object.keys(self.data.operators).length
          $('#chart').flowchart('setData', self.data)
        }
      })
    }
  }
}
</script>

<style>
.container {
  width: 800px;
  height: 400px;
}
.flowchart-container {
  width: 800px;
  height: 4000px;
}
#chart {
  width: 800px;
  height: 400px;
}
h1,
h2 {
  font-weight: normal;
}
a {
  color: #42b983;
}
.flowchart-operator-outputs .flowchart-operator-connector-arrow {
  right: 0px;
}
.flowchart-operator-connector {
  position:unset;
  padding-top: 0px;
  padding-bottom: 0px;
}
.flowchart-operator .flowchart-operator-inputs-outputs {
  margin-top: 0px;
  margin-bottom: 0px;
  border-radius:10px;
}
.flowchart-operator-connector-arrow {
  top:22px;
}
.flowchart-operator {
  border:0px;
}
.DataTask{
  padding:15px;
  color:white;
  height:60px !important;
  background: linear-gradient(to right, #6e2a8a , #c280d8);
  border-radius: 8px;
  border-bottom: 0px;
}
.DataTask  .flowchart-operator-connector-arrow {
  border: 6px solid rgb(162, 23, 221);
  border-radius: 6px;
}
.flowchart-operator .flowchart-operator-title{
  background:transparent;
  border-bottom:0px;
}
.DataTask .flowchart-operator-connector:hover .flowchart-operator-connector-arrow {
  border-left: 6px solid rgb(162, 23, 221);
}
.flowchart-operator-inputs .flowchart-operator-connector-arrow {
  left: -5px;
}
.flowchart-operator-outputs .flowchart-operator-connector-arrow {
  right: -5px;
}
.Train .flowchart-operator-connector-arrow {
  border: 6px solid rgb(161, 225, 236);
  border-radius: 6px;
}
.flowchart-operator-connector-small-arrow {
  border:0px;
}
.Train {
  padding: 15px;
  color:white;
  height:60px;
  background: linear-gradient(to right, #278ea0 , #88dfee);
  border-radius: 8px;
  border-bottom: 0px;
}
.Train .flowchart-operator-connector:hover .flowchart-operator-connector-arrow {
  border-left: 6px solid rgb(161, 225, 236);
}
.Deploy .flowchart-operator-connector-arrow {
  border: 6px solid rgb(252, 22, 103);
  border-radius: 6px;
}
.Deploy {
  padding: 15px;
  color:white;
  height:60px;
  background: linear-gradient(to right, #f7482a ,#f72a71);
  border-radius: 8px;
  border-bottom: 0px;
}
.Deploy .flowchart-operator-connector:hover .flowchart-operator-connector-arrow {
  border-left: 6px solid rgb(252, 22, 103);
}
.icon {
  width:28px;
}
.buttonTopRight {
  float:right;
}
#select-components {
 display:  inline-block;
}
.savebtn {
  background: transparent !important;
  border: 0px;
}
.savebtn:focus, .savebtn:hover {
  background: transparent !important;
  border: 0px;
  outline:0px !important;
  box-shadow:none;
}
.card-header {
  display:inherit;
  text-align: left;
}
</style>
