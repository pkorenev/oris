$('#st-accordionx').accordion({
    oneOpenedItem	: true
});


$("body").on "click", ".open-vacancy-request-popup", (event)->
  event.preventDefault()
  $link = $(this)
  url = $link.attr("href")
  $popup = $("#vacancy-request-popup")
  $form = $popup.find("form")
  $form.resetForm()
  $form.attr("action", url)
  $("#vacancy-request-popup").popup('show')

