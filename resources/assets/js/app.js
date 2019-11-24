
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

import Vue from 'vue'
import axios from 'axios'
import VueAxios from 'vue-axios'
import BootstrapVue from 'bootstrap-vue'
var VueTruncate = require('vue-truncate-filter')
import { library } from '@fortawesome/fontawesome-svg-core'
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';

import { faCalendarAlt, faMapMarkerAlt, faBackspace, faTag, faColumns, faAlignJustify, faPencilAlt, faCheck, faBan, faPlus, faCalendarCheck, faTasks, faTimes, faTrashAlt, faArchive, faClock, faIdBadge, faStar, faEye, faEllipsisH, faLongArrowAltLeft, faUndo, faImages, faUsers } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import datePicker from 'vue-bootstrap-datetimepicker';
import 'bootstrap/dist/css/bootstrap.css';
import 'pc-bootstrap4-datetimepicker/build/css/bootstrap-datetimepicker.css';
import VueBootstrapTypeahead from 'vue-bootstrap-typeahead'
import Autocomplete from 'vuejs-auto-complete'
 
// Global registration

library.add(faCalendarAlt, faMapMarkerAlt, faBackspace, faTag, faColumns, faAlignJustify, faPencilAlt, faCheck, faBan, faPlus, faCalendarCheck, faTasks, faTimes, faTrashAlt, faArchive, faClock, faIdBadge, faStar, faEye, faEllipsisH, faLongArrowAltLeft, faUndo, faImages, faUsers)
Vue.component('font-awesome-icon', FontAwesomeIcon)
Vue.config.productionTip = false;
Vue.use(VueTruncate)
Vue.use(VueAxios, axios)
Vue.use(VueSweetalert2);
Vue.use(BootstrapVue);
Vue.use(datePicker);
Vue.use(require('vue-moment'));

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

Vue.component('example', require('./components/Example.vue'));
Vue.component('home', require('./components/Home.vue'));
Vue.component('boardlist', require('./components/BoardList.vue'));
Vue.component('card', require('./components/Card.vue'));
Vue.component('navbar', require('./components/Navbar.vue'));
Vue.component('board', require('./components/Board.vue'));
Vue.component('archive', require('./components/Archive.vue'));
Vue.component('archivenavbar', require('./components/ArchiveNavbar.vue'));
Vue.component('dashboardnav', require('./components/DashboardNav.vue'));
Vue.component('vue-bootstrap-typeahead', VueBootstrapTypeahead)
Vue.component('autocomplete', Autocomplete)


const home = new Vue({
    el: '#home'
});

const board = new Vue({
	el: '#board'
});

const archive = new Vue({
	el: '#archive'
});
