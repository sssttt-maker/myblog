$(function() {

  var windowHeight = $(window).height();
  // post slider
  $('.post-slider').slick({
    arrows: false,
    autoplay: true,
    dots: true,
    fade: false,
    slidesToShow: 3,
    centerMode: true,
    variableWidth: true,
  });

  // gallery modal
  $('.modal-open-box').each(function() {
    $(this).click(function() {
      var id = $(this).data('id')
      $('.modal').fadeIn();
      $.ajax({
        type: 'GET',
        url: '/galleries/image',
        data: {
          image: {
            id: id
          }
        },
        dataType: 'json'
      })
      .done(function(data) {
        $.each(data['url'], function(i) {
          $('.modal-img-wrap').append('<div><img src="' + data['url'][i] +'" /></div>')
        })
        $('.modal-description').html(data['description'])
        $('.modal-img-wrap').slick({
          infinite: false
        });
      });
    });
  });

  $('.modal-close').on('click', function() {
    $.when(
      $('.modal').fadeOut(),
    ).done(function() {
      $('.modal-img-wrap, .modal-description').empty();
      $('.modal-img-wrap').removeClass().addClass('modal-img-wrap')
      return false
    });
  });
});
