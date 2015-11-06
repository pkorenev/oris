$("body").on "submit", ".popup form", (event)->
  event.preventDefault()

  $form = $(this)
  $popup = $form.closest(".popup")
  data = $form.serializeArray()
  url = $form.attr("action")
  method = $form.attr("method")

  $form.ajaxSubmit(
    success: ()->
      $popup.popup("hide")

      $("#vacancy-request-success-popup").popup("show")
  )


