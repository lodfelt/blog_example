$(document).ready ->
  $("#new_article_image").fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) or types.test(file.name)
        data.submit()
      else
        alert "" + file.name + " is not a gif, jpeg, or png image file"

  $("#article-images").on "submit", ".edit_article_image", ->
    $form = @
    $.post $form.attr("action"), $form.serialize(), (data) ->
      $form.closest("li").replaceWith data

    false


  $("#article-images").on "click", ".btn-danger", ->
    $form = $(this).closest("form")
    data =
      _method: "delete"
      authenticity_token: $form.find("input[name='authenticity_token']").val()

    $.post $form.attr("action"), data, (data) ->
      $form.closest("li").fadeOut()

    false

  $("#article_published_on").datepicker dateFormat: "yy-mm-dd"

  $("body").on "click", "#article_use_editor_true", ->
    $("#article_markdown").closest(".control-group").addClass "hidden"
    $(".wysihtml5-sandbox").closest(".control-group").removeClass "hidden"

  $("body").on "click", "#article_use_editor_false", ->
    $(".wysihtml5-sandbox").closest(".control-group").addClass "hidden"
    $("#article_markdown").closest(".control-group").removeClass "hidden"

  $(".wysihtml5").each (i, textarea) ->
    $(textarea).wysihtml5()