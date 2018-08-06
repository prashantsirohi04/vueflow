<template>
  <div class='ui basic content center aligned segment'>
    <div class='tv-content'>
      <div class='tvfield field'>
        <div class="input-group mb-3">
          <div class="input-group-prepend">
            <span class="input-group-text" id="basic-addon1" :model="key">key{{count}}</span>
          </div>
          <input v-model="value" class="tv-input form-control">
          <button @click="addmore()" class="b-trans add-btn form-control" v-if="count<2">+</button>
          <button @click="remove()" v-if="count >1" class="b-trans rmv-btn form-control">x</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['name', 'count'],
  data () {
    return {
      top: '',
      value: '',
      key: ''
    }
  },
  methods: {
    addmore () {
      this.$emit('add')
    },
    remove () {
      this.$emit('remove')
    }
  }
}
</script>

<style scoped>
.tv-content {
  width: 301px;
}

.b-trans {
  background: transparent;
  border: none;
  position: absolute;
  right: 0px;
  border: 0px;
  border-radius: 0px 4px 4px 0px;
  top: 1px;
  text-align: center;
  padding: 0px;
  height: 37px;
  width: 30px
}

.add-btn {
  color: blue;
  background-color: #9ad0f4;
}

.rmv-btn {
  color: red;
  background-color: #f4b6a4;
}

.tv-input {
  border-radius: 0px .25rem .25rem 0px !important;
  padding-right: 34px;
}
.tv-input:focus {
  z-index:unset;
}

.tvfield {
  margin-bottom: 10px;
}
</style>
