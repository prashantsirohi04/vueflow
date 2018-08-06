import Vue from 'vue'
import Router from 'vue-router'
import Flowchart from '@/components/Flowchart'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Flowchart',
      component: Flowchart
    }
  ]
})
