
$(function() {

  $('a#tab_survey').click(function() {
    $('div#forms').addClass('hidden');
    $('div#survey').removeClass('hidden');
    $('li#li_forms').removeClass('active');
    return $('li#li_survey').addClass('active');
  });

  $('a#tab_forms').click(function() {
    $('div#survey').addClass('hidden');
    $('div#forms').removeClass('hidden');
    $('li#li_forms').addClass('active');
    return $('li#li_survey').removeClass('active');
  });

  $('a#tab_forms').click();

  return $('#assign_forms').click(function() {
    const forms = [];
    $('div#forms input:checked').each( function() {
      return forms.push($(this).val());
    });
    $.ajax({
      method: 'post',
      url: '/surveys/' + $('input#survey_id').val() + '/assign_forms',
      data: { survey: forms },
      success(result) {}
    });
  });
});
