(function($){
    $(document).ready(function(){

        //bxslider
        $('#slide-counter').prepend('<span class="current-index"></span> / ');

        var slider = $('.bx_px').bxSlider({
            auto: true,
            pager: false,
            onSliderLoad: function (currentIndex){
                $('#slide-counter .current-index').text(currentIndex + 1);
            },
            onSlideBefore: function ($slideElement, oldIndex, newIndex){
                $('#slide-counter .current-index').text(newIndex + 1);
            }
        });

        $('#slide-counter').append(slider.getSlideCount());

    });

})(jQuery);