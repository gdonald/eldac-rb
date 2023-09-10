import { Controller } from "@hotwired/stimulus"
// import "select2"

export default class extends Controller {
  connect() {
    console.log('connected select2 controller')

    var select2Executed = false;
    document.addEventListener('turbo:load', function() {
    //$(function() {
      console.log('turbo:load')

      //console.log('importmapScriptsLoaded:', window.importmapScriptsLoaded)

      if (window.importmapScriptsLoaded === true) { 
        console.log('importmapScriptsLoaded :)')
      } else {
        console.log('importmapScriptsLoaded not ready')
      }

      if (window.importmapScriptsLoaded) { 
        if (!select2Executed) {

          //console.log($('#hello'));

          $('.js-data-example-ajax').select2({
            ajax: {
              url: 'https://api.github.com/search/repositories',
              dataType: 'json'
              // Additional AJAX parameters go here; see the end of this chapter for the full code of this example
            }
          });

          

          select2Executed = true;
          console.log('select2 executed')
        }
      }
    })
  }
}




// export default class extends Controller {
//   connect() {
//     var prismExecuted = false;
//     document.addEventListener('turbo:load', function() {
//       if ('prismReady' in window) { 
//         if (!prismExecuted) {
//           Prism.highlightAll();
//           prismExecuted = true;
//         };  
//       };
//     });
//   }
// }