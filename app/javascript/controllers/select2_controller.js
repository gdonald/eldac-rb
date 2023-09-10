import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('connected select2 controller')

    var select2Executed = false;
    document.addEventListener('turbo:load', function() {
      console.log('turbo:load')

      if ('jqueryReady' in window) { 
        console.log('jqueryReady')
      } else {
        console.log('jquery not ready')
      }

      if ('jqueryReady' in window) { 
        if (!select2Executed) {
          $('.js-data-example-ajax').select2({
            ajax: {
              url: 'https://api.github.com/search/repositories',
              dataType: 'json'
              // Additional AJAX parameters go here; see the end of this chapter for the full code of this example
            }
          });
          select2Executed = true;
          log('select2 executed')
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