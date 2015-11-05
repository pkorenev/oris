$("body").on "submit", ".popup form", (event)->
  event.preventDefault()
  $form = $(this)
  data = $form.serializeArray()
  url = $form.attr("action")
  method = $form.attr("method")

  $form.ajaxSubmit()

