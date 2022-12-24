
window.saveFieldsSort = function() {
  const order = $('#sort_fields tbody').sortable('serialize');
  $.ajax({
    method: 'post',
    url: '/sections/' + $('#field_section_id').val() + '/fields/save_sort',
    data: { order
  },
    success(result) {}
  });
};

window.askDeleteField = function(id) {
  const section_id = $('#field_section_id').val();
  $.ajax({
    method: 'get',
    url: '/sections/' + section_id + '/fields/' + id + '/ask_delete'
  });
};

$(function() {

  $('#sort_fields tbody').sortable({
    cursor: 'move',
    opacity: 0.7,
    update(e, ui) {
      saveFieldsSort();
    }
  });

  return $('a[id^="ad_field_"]').each(function() {
    return $($(this)).click(function() {
      askDeleteField($(this).attr('id').split('_')[2]);
    });
  });
});
