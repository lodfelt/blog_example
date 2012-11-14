$(document).ready(function() {
  $('#new_article_image').fileupload({
    dataType: "script",
    add: function(e, data) {
      var file, types;
      types = /(\.|\/)(gif|jpe?g|png)$/i;
      file = data.files[0];
      if (types.test(file.type) || types.test(file.name)) {
        data.context = $(tmpl("template-upload", file));
        console.log(data.context);
        $('#new_article_image').prepend(data.context);
        data.submit();
      } else {
        alert("" + file.name + " is not a gif, jpeg, or png image file");
      }
    },
    // progress: function(e, data) {
    //   var progress = 0;
    //   if (data.context) {
    //     progress = parseInt((data.loaded / data.total * 100)+1);
    //     data.context.find('.bar').css('width', progress + '%');
    //   }
    // }
  });

});