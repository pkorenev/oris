//= require libs/jquery/jquery-1.11.3.min
//= require application/jquery.matchHeight-min.js
//= require application/jquery.popupoverlay.js
//= require application/jquery.bxslider.js
//= require application/jquery.fatNav.min
//= require application/jquery.counterup.min.js
//= require application/waypoints.min.js
//= require application/jquery.easyResponsiveTabs
//= require application/simplemenu.js
//= require application/common
//= require application/js



// script
$('.site-search__icon').click(function() {
    $('body').toggleClass('site-search--active');
});


// script
$('#my_popup').popup({
    transition: 'all 0.3s'
});

// script
jQuery(document).ready(function( $ ) {
    $('.counter').counterUp({
        delay: 10,
        time: 1500
    });
});

// script
(function() {

    $.fatNav();

}());

// script
$(function() {
    $('.tt_bot').matchHeight();
});

// script
$(function() {
    $('.m_nor').matchHeight();
});

// script
$(function() {
    $('.plan_tab').matchHeight();
});

// script
$('.bxslidere').bxSlider({
    nextSelector: '#slider-next',
    prevSelector: '#slider-prev',
    pager: false,
    nextText: 'Onward',
    prevText: 'Go back'
});