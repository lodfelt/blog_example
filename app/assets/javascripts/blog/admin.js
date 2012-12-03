$(document).ready(function() {
  $('#new_article_image').fileupload({
    dataType: "script",
    add: function(e, data) {
      var file, types;
      types = /(\.|\/)(gif|jpe?g|png)$/i;
      file = data.files[0];
      if (types.test(file.type) || types.test(file.name)) {
        // data.context = $(tmpl("template-upload", file));
        // $('#new_article_image').prepend(data.context);
        data.submit();
      } else {
        alert("" + file.name + " is not a gif, jpeg, or png image file");
      }
    }
  });

  $('#article-images').on('submit', '.edit_article_image', function(e){
    var $form = $(this);
    $.post(
      $form.attr('action'),
      $form.serialize(),
      function (data) {
        $form.closest('li').replaceWith(data);
      }
    );
    return false;
  });

  $("#article-images").on('click', '.btn-danger', function(e){
    var $form = $(this).closest('form');
    var data = {'_method':'delete', 'authenticity_token':$form.find("input[name='authenticity_token']").val()};

    $.post(
      $form.attr('action'),
      data,
      function (data) {
        $form.closest('li').fadeOut();
      }
    );

    return false;
  });

  $('#article_published_on').datepicker({dateFormat: 'yy-mm-dd'});
});