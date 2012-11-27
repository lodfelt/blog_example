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

  $('.form-search').submit(function(){
    var $form = $(this);
    var data = $form.serialize();
    $.get(
      $form.attr('action'),
      data,
      function (data) {
        $("#article-section").empty().append(data);
      }
    );
    return false;
  });
  $("#article-section").on("click", ".pagination a", function() {
    $.get(
      this.href,
      function (data) {
        $("#article-section").empty().append(data);
      }
    );
    return false;
  });

  $('.nav-tabs a').click(function(e) {
    var $tab = $(this);
    var $otherTab = $tab.parent().siblings().find('a');
    $($tab.attr('href')).toggle();
    $tab.parent().toggleClass('active');

    $($otherTab.attr('href')).toggle();
    $otherTab.parent().toggleClass('active');
    return false;
  });
});