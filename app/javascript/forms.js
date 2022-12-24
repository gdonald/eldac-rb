
window.savePagesSort = function() {
  const order = $('#sort_pages tbody').sortable('serialize');
  $.ajax({
    method: 'post',
    url: '/forms/' + $('#page_form_id').val() + '/pages/save_sort',
    data: { order
  },
    success(result) {}
  });
};

window.askDeletePage = function(id) {
  $.ajax({
    method: 'get',
    url: '/forms/' + $('#page_form_id').val() + '/pages/' + id + '/ask_delete'
  });
};

$(function() {

  $('#sort_pages tbody').sortable({
    cursor: 'move',
    opacity: 0.7,
    update(e, ui) {
      savePagesSort();
    }
  });

  return $('a[id^="ad_page_"]').each(function() {
      return $($(this)).click(function() {
        askDeletePage($(this).attr('id').split('_')[2]);
      });
  });
});
