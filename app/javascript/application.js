
import './add_jquery'
import './add_select2'

import "@hotwired/turbo-rails"

import "./controllers"

// import * as jquery from 'jquery'
//import 'jquery'
// import * as jq from 'jquery'
// window.$ = jq
// window.jQuery = jq

// // import {} from 'jquery-ujs'

import * as bootstrap from "bootstrap"



//import * as select2 from "select2"

// import jQuery from "jquery"
// window.jQuery = jQuery // <- "select2" will check this
// window.$ = jQuery


console.log('importmapScriptsLoaded almost ready:', window.importmapScriptsLoaded);

window.importmapScriptsLoaded = true;

console.log('importmapScriptsLoaded ready:', window.importmapScriptsLoaded);
