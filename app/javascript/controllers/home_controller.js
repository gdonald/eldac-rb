import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("home controller has been connected");

    $("#q").autocomplete({
      source : function(request, response) {
        $.ajax({
          url : "/search/autocomplete",
          type : "GET",
          data : {
            term : request.term
          },
          dataType : "json",
          success : function(data) {
            response(data);
          }
        });
      },
      select: function( event, ui ) {
        alert( ui.item.value );
        // Your code
        return false;
      }
    });
  }
}
