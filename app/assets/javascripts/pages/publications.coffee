#$(document).pjax(".category-tabs a", ".category-tab-content")
#
#$("body").on "pjax:click", ".category-tabs li", (options)->
#  $(".category-tabs li").removeClass("active")
#  $(this).addClass("active")
#  window.OPTIONS = options


#$(".ajax-load")

#$("body").on "click", ".accordion li > a", (e)->
#  e.preventDefault()
#  console.log "event"
#
#  $link = $(this)
#  $li = $link.closest("li")
#  $li.addClass("st-open")
#  $container = $link.next()
#  empty_container = $container.children().length == 0
#  url = $link.attr("href")
#  $.pjax({
#    url: url
#    container: $container
#  })
#
#
#
#  top = $link.offset().top
#  $("html, body").animate({scrollTop: top})