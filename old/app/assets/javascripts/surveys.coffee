
$ ->

  $('a#tab_survey').click ->
    $('div#forms').addClass('hidden')
    $('div#survey').removeClass('hidden')
    $('li#li_forms').removeClass('active')
    $('li#li_survey').addClass('active')

  $('a#tab_forms').click ->
    $('div#survey').addClass('hidden')
    $('div#forms').removeClass('hidden')
    $('li#li_forms').addClass('active')
    $('li#li_survey').removeClass('active')

  $('a#tab_forms').click()

  $('#assign_forms').click ->
    forms = []
    $('div#forms input:checked').each( ->
      forms.push $(this).val()
    )
    $.ajax
      method: 'post'
      url: '/surveys/' + $('input#survey_id').val() + '/assign_forms'
      data: { survey: forms }
      success: (result) ->
    return
