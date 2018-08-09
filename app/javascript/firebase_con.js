import Firebase from 'firebase'
var config = {
  apiKey: 'AIzaSyD_K8S8tbrzAmiqn4MSwRJQ-jO2-sNB_OU',
  authDomain: 'fir-vue-543d1.firebaseapp.com',
  databaseURL: 'https://fir-vue-543d1.firebaseio.com',
  projectId: 'fir-vue-543d1',
  storageBucket: '',
  messagingSenderId: '735976470373'
}

Firebase.initializeApp(config)
const firestore = Firebase.firestore()
const settings = {timestampsInSnapshots: true}
firestore.settings(settings)

export const DATATBASE = Firebase.firestore()
