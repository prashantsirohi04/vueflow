<template>
  <!--<b-modal ref="modal1"  v-model="show">-->
  <transition name="modal" v-if="show">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
          <div class="row">
            <div class="col-md-6" style="padding-right:0px;">
              <div class="img-container"><img src="../assets/medical-record.svg" class="file-icon" style="width:50px;">
              </div>
              <input type="text" v-model="card_title" class="card_title">
              <div class='ui-basic'>
                <div class='content'>
                  <div class='field' style="position: relative;left: 18px;width:302px;">
                    <input class="form-control" v-model="title" placeholder="choose an input script" :rows="1" list="suggestions">
                    <datalist id="suggestions">
                      <option v-for="(sug,index) in suggestions"
                        v-bind:key="index"
                        :value="sug"><h2>{{sug}}</h2>
                      </option>
                    </datalist>
                  </div>
                  <span class="tvpair">Tag-Value Pairs </span>
                  <div class="component-contain">
                    <tag-value-pair style="position: relative;left:15px;" v-for="n in count" @add="add()" @remove="remove()" :key="n" :count="n"></tag-value-pair>
                  </div>
                  <div class='attached-buttons'>
                    <button class='cancel form-control bottom_btn' @click="close()">
                      CANCEL
                    </button>
                    <button class='delete form-control bottom_btn' v-on:click="close()">
                      DELETE
                    </button>
                    <button class='save form-control bottom_btn' v-on:click="sendForm">
                        SAVE
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-6" style="padding-left:0px;">
              <div class="left-container">
                <button type="button" class="close" aria-label="Close" @click="close()">
                  <span aria-hidden="true">&times;</span>
                  </button>
                <div class="parameterWrap" style="width:100%">
                  <span class="imgTop">
                    <img src="../assets/medical-record.svg" class="file-icon" style="width:30px;">
                    </span>
                  <span class="title" style="color:white;font-size:26px;padding-left:30px;">{{card_title}}</span>
                  <span class="name" style="color:white;padding-right:131px;">Made by Yochay</span>
                </div>
                <div>
                  <h4 style="padding-left:36px; color:white;font-size: 23px;
                    margin: 0px;">Configurable params:</h4>
                  <div>
                  </div>
                  <div class="checkbox-options">
                    <div class="bgColor">
                      <div><span>✔︎</span>Shared to team</div>
                      <div><span>✔︎</span>Customizable Hyperparams</div>
                      <div><span>✔︎</span>Set default for easy repeat setup</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import TagValuePair from './TagValuePair'
export default {
  props: ['show', 'name'],
  components: {
    TagValuePair
  },
  data () {
    return {
      top: '',
      left: '',
      count: 1,
      title: '',
      openmodal: this.show,
      checked: true,
      suggestions: ['abc', 'xyz'],
      card_title: 'title'
    }
  },
  mounted: function () {
    this.checked = true
    this.count = 1
  },
  methods: {
    add () {
      this.count++
    },
    remove () {
      this.count--
    },
    close () {
      this.count = 1
      this.$emit('close')
    },
    clearForm () {
      this.title = ''
    },
    sendForm () {
      if (this.title.length > 0) {
        this.$emit('add-operator', {
          top: 50,
          left: 60,
          properties: {
            title: this.title,
            class: this.name,
            inputs: {
              input_1: {
                label: ''
              }
            },
            outputs: {
              output_1: {
                label: ''
              }
            }
          }
        })
      }
      this.clearForm()
    }
  }
}
</script>

<style>
.modal-header {
  border-bottom: 0px;
  padding: 0px;
}
.modal-enter {
  opacity: 0;
}
.modal-leave-active {
  opacity: 0;
}
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
}
.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}
.modal-container {
  width: 680px;
  margin: 0px auto;
  background-color: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
.left-container {
  height: 500px;
  background-color: #14202d;
  border-radius: 0px 12px 12px 0px;
}
.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
.default-options {
  width: 267px;
  text-align: left;
  padding: 10px;
  position: relative;
  left: 30px;
  border-radius: 10px;
  color: white;
  background-color: #343e48;
}
.custom-checkbox .custom-control-input:checked~.custom-control-label::before {
  background-color: #343e48;
}
.attached-buttons {
  background-color: transparent;
  display: flex;
  justify-content: center;
  height: 121px;
  align-items: flex-end;
  width: 100%;
  box-sizing: border-box;
  padding: 0px 17px;
}
.bottom_btn {
  margin: 0px 5px;
}
.cancel {
  background-color: #c9cacc;
  color: #46494c;
  border-radius: 4px;
  border: none;
}
.delete {
  background-color: #fcb792;
  color: #f41637;
  border: none;
}
.save {
  background-color: #7bc5f7;
  color: #1060ea;
  border: none;
}
.component-contain {
  padding-left: 4px;
  height: 100px;
  overflow: hidden;
  overflow-y: auto;
}
.checkbox-options {
  padding: 7px 25px 7px 44px;
  min-height: 100px;
  text-align: left
}
.checkbox-options div {
  font-size: 12px;
  font-weight: 200;
  line-height: 1.69;
  color: #ffffff;
}
.checkbox-options span {
  font-size: 14px;
  color: #5ebeff;
  margin-right: 8px;
}
.card_title {
  text-align: center;
  border: none;
  text-decoration: underline;
  margin-bottom: 25px;
  color: gray;
  width: 100%
}
.card_title:focus {
  outline: 0px;
}
.img-container {
  display: flex;
  justify-content: center;
  height: 100px;
}
.tvpair {
  display: block;
  text-align: left;
  padding: 10px 18px;
}
.parameterWrap {
  text-align: left;
  padding-left: 44px;
  padding-top: 24px;
}
.parameterWrap span {
  display: block;
}
.imgTop {
  margin-left: -5px;
  margin-bottom: 5px;
}
.title {
  padding-left: 0px !important;
  font-size: 20px !important;
}
.name {
  padding: 0px;
  font-size: 10px;
  margin-bottom: 25px;
}
.bgColor {
  border-radius: 12px;
  background-color: rgba(0, 0, 0, 0.14);
  padding: 5px 14px;
}
.close {
  display: inline-block;
  font-size: 13px;
  color: gray;
  text-shadow: none;
  box-shadow: none;
  border-radius: 100%;
  background-color: rgba(0, 0, 0, 0.14) !important;
  width: 20px;
  height: 21px;
  line-height: 20px;
  text-align: center;
  opacity: 1;
  box-sizing: border-box;
  padding: 0px 7px;
  position: absolute;
  right: 41px;
  top: 20px;
}
.close:hover,
.close:focus {
  color: gray !important;
  opacity: 1;
  outline: none;
}
</style>
