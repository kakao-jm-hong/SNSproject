import Vue from 'vue'
import Vuex from 'vuex'
import getters from './getters'
import actions from './actions'
import mutations from './mutations'
import cookies from 'vue-cookies'


Vue.use(Vuex)

const state = {
    authToken: cookies.get('auth-token'),
    isLoggedIn : false,
    email : cookies.get('auth-email'),
    profileData: [],
    clubs: [],
    detailFeed: [],
    userprofiledata: [],
    followerList: [],
    followList: [],
    getTeams: [],
    followflag: true,
    followCnt: '',
}

export default new Vuex.Store({
    state,
    mutations,
    getters,
    actions
})