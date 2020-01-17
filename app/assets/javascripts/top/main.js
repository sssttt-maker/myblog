$(function() {
  var windowWidth = $(window).width();
  var windowHeight = $(window).height();
  var breakPoint = 576;
  $(window).on('load resize', function() {
    windowHeight = $(window).height();
    windowWidth = $(window).width();
    if(windowWidth > breakPoint) {
      // top hover
      $('.item-box').each(function() {
        $(this).on('mouseover', function() {
          $(this).find('.overlay').stop(true).animate({ opacity: 1 }, 300);
        }).on('mouseout', function() {
          $(this).find('.overlay').stop(true).animate({ opacity: 0 }, 300);
        })
      });
    } else {
      $('.toUnder').on('click', function() {
        var containerHeight = $('.container').offset().top;
        $('html,body').stop(true).animate({scrollTop: containerHeight - $('.navbar').innerHeight()}, 500);
      })
    }
  });

  // scroll nav
  $(window).scroll(function() {
    var scrollPos = $(window).scrollTop();
    if(scrollPos > windowHeight) {
      $('.top-nav').addClass('bg-dark');
    } else {
      $('.top-nav').removeClass('bg-dark');
    }
  });

});
