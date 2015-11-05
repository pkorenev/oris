#$(document).pjax("a", ".publications-tab-content")

$("body").on "pjax:click", ".publications-tabs a", ()->
  $(".publications-tabs a").removeClass("p_activ")
  $(this).addClass("p_activ")