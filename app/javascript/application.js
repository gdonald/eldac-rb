
import './add_jquery'

import "@hotwired/turbo-rails"

import "./controllers"

import * as bootstrap from "bootstrap"

console.log('importmapScriptsLoaded almost ready:', window.importmapScriptsLoaded);

window.importmapScriptsLoaded = true;

console.log('importmapScriptsLoaded ready:', window.importmapScriptsLoaded);
