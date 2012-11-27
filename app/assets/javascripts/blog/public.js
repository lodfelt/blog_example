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

    if(!$tab.parent().hasClass('active')) {
      $($tab.attr('href')).toggle();
      $tab.parent().addClass('active');

      $($otherTab.attr('href')).toggle();
      $otherTab.parent().removeClass('active');
    }

    var cookieName = 'tab-' + $tab.attr('href');
    var otherCookieName = 'tab-' + $otherTab.attr('href');
    if(!$.cookie(cookieName)) {
      $.cookie(cookieName, 'choosen', { path: '/', expires: 1 } );
    }

    if($.cookie(otherCookieName)) {
      $.removeCookie(otherCookieName, { path: '/' });
    }

    return false;
  });

  checkTabCookies()
});

function checkTabCookies() {
  $('.nav-tabs a').each(function(i, link) {
    var cookieName = 'tab-' + $(link).attr('href');
    if($.cookie(cookieName)) {
      $(link).click();
    }
  });
}