(function() {
  var countTourInCategory, slider_array, toggleFiltersClass;


  slider_array = new Array();

  jQuery(document).ready(function($) {
    var a, b;
    a = {
      controls: false,
      pause: 5000,
      pagerCustom: '#custom-thumbnails',
      responsive: true
    };
    b = {
      controls: false,
      pause: 5000,
      pagerCustom: '#custom-thumbnails',
      responsive: false
    };
    $(".bxslider").each(function(i) {
      if ($(this).hasClass('first-main-banner')) {
        return slider_array[i] = $(this).eq(0).bxSlider(a);
      } else if ($(this).hasClass('second-main-banner')) {
        return slider_array[i] = $(this).eq(0).bxSlider(b);
      }
    });
    $(".bx-controls-direction a").bind("click", function(e) {
      e.preventDefault();
      if ($(this).hasClass("bx-prev")) {
        return $.each(slider_array, function(i, elem) {
          return elem.goToPrevSlide();
        });
      } else if ($(this).hasClass("bx-next")) {
        return $.each(slider_array, function(i, elem) {
          return elem.goToNextSlide();
        });
      }
    });
    $('.wrap-for-sending-form form').submit(function(event) {
      var $loading, $statusWindow, $succes, $thisForm, $wrapper, formData;
      event.preventDefault();
      $wrapper = $(this).closest('.wrap-for-sending-form');
      $statusWindow = $wrapper.find('.sending-status-wrap');
      $loading = $statusWindow.find('.sending-wrap');
      $succes = $statusWindow.find('.success-wrap');
      $thisForm = $(this).closest('form');
      formData = $thisForm.serialize();
      return $.ajax({
        type: "POST",
        url: $thisForm.attr("action"),
        data: formData,
        beforeSend: function() {
          return $statusWindow.removeClass('hide');
        },
        success: function() {
          $loading.addClass('hide');
          return $succes.removeClass('hide');
        },
        complete: function() {
          return setTimeout((function() {
            return $thisForm.find("input[type=text],input[type=email], textarea").val("");
          }), 3000);
        },
        error: function() {
          return alert("Something went wrong!");
        }
      });
    });
    return $('.close-modal-button').click(function() {
      var $modalWrap, $sendingWrap, $statusWrap, $thisForm, $wrapper;
      $statusWrap = $(this).closest('.sending-status-wrap');
      $sendingWrap = $statusWrap.find('.sending-wrap');
      $modalWrap = $(this).closest('.success-wrap');
      $wrapper = $(this).closest('.order-event-form-wrap');
      $thisForm = $wrapper.find('form');
      $statusWrap.addClass('hide');
      $sendingWrap.removeClass('hide');
      return $modalWrap.addClass('hide');
    });
  });

}).call(this);
