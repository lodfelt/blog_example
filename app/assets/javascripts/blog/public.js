$(document).ready(function() {
  $('.comment-on-article').click(function(e) {
    $(this).siblings('form').slideToggle();
    return false;
  });

  $('#edit-user-modal').on('click', '.btn-primary', function(e){
    var $form = $("#edit-user-modal").find('form');
    $form.submit();
    return false;
  });
});