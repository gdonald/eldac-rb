(() => {
  // app/javascript/pages.js
  window.saveSectionsSort = function() {
    const order = $("#sort_sections tbody").sortable("serialize");
    $.ajax({
      method: "post",
      url: "/pages/" + $("#section_page_id").val() + "/sections/save_sort",
      data: {
        order
      },
      success(result) {
      }
    });
  };
  window.askDeleteSection = function(id) {
    const page_id = $("#section_page_id").val();
    $.ajax({
      method: "get",
      url: "/pages/" + page_id + "/sections/" + id + "/ask_delete"
    });
  };
  $(function() {
    $("#sort_sections tbody").sortable({
      cursor: "move",
      opacity: 0.7,
      update(e, ui) {
        saveSectionsSort();
      }
    });
    return $('a[id^="ad_section_"]').each(function() {
      return $($(this)).click(function() {
        askDeleteSection($(this).attr("id").split("_")[2]);
      });
    });
  });
})();
//# sourceMappingURL=assets/pages.js.map
