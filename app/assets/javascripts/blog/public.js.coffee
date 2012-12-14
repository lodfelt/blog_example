$(document).ready ->

  $("#login-modal").on 'keyup', "#new_user input[type='text'], #new_user input[type='password']", (e) ->
    if e.which == 13
      $(this).closest('form').submit()
    true

  if $("#nav-tabs").length < 1
    $("form.form-search").hide()

  if $(".breadcrumb").children().size() < 2
    $(".breadcrumb").closest('.row').remove()

  $('.comment-on-article').click ->
    $(this).siblings('form').slideToggle()
    false

  $('#edit-user-modal').on 'click', '.btn-primary', ->
    $("#edit-user-modal").find('form').submit()
    false

  $("#login-modal .modal-footer").on "click", "button[type='submit']", ->
    $("#login-modal #new_user").submit()

  $('.form-search').submit ->
    $form = $(@)
    $.get $form.attr('action'), $form.serialize(),
     (data) ->
        $("#article-section").empty().append(data)
        $("#articles-tab").click()
    false

  $("#article-section").on "click", ".pagination a", ->
    $.get this.href,
      (data) ->
        $("#article-section").empty().append(data)
    false

  $('.nav-tabs a').click ->
    $(this).tab('show')
    false

  $('.carousel').carousel()
