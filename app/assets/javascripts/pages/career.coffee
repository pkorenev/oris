#$('#st-accordionx').accordion({
#    oneOpenedItem	: true
#});


$("body").on "click", ".open-vacancy-request-popup", (event)->
  event.preventDefault()
  $link = $(this)
  url = $link.attr("href")
  $popup = $("#vacancy-request-popup")
  $form = $popup.find("form")
  $form.resetForm() if $form.length > 0 && $form.resetForm
  $form.attr("action", url)
  $("#vacancy-request-popup").popup('show')



$(".accordion-ul > li > div").slideUp()

$(".accordion").on "click", ".accordion-ul > li > a", (e)->
  e.preventDefault()
  $link = $(this)
  $li = $link.closest("li")
  $content = $li.find(">div")

  scroll_top = $li.offset().top

  $ul = $li.closest("ul")

  if !$li.hasClass("opened")
    $ul.children().filter(".opened").removeClass("opened").slideUp()

    $li.addClass("opened")
    $content.slideDown()

    $("html, body").animate({
      scrollTop: scroll_top
    })
  else
    $li.removeClass("opened")
    $content.slideUp()

  $(this).closest(".isotope-grid").isotope()

