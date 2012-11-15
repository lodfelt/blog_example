$(document).ready(function() {
  $('.comment-on-article').click(function(e) {
    $(this).siblings('form').slideToggle();
    return false;
  });
});