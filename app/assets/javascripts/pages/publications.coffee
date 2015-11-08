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


$isotope_grid = $(".isotope-grid")
isotope_grid_layout = 'fitRows'
isotope_grid_layout = 'vertical' if $isotope_grid.hasClass('isotope-grid-vertical')

$isotope_grid.isotope({
  itemSelector: ".isotope-grid-item"
  layoutMode: isotope_grid_layout,
  fitRows: {

  }
  masonry: {
    columnWidth: '.grid-sizer'
  }
  getSortData: {
    name: "[data-name]"
    date: "[data-date]"
  }
})


$("body").on "click", ".category-tabs [data-filter]", (e)->
  e.preventDefault()
  $tab = $(this)
  if !$tab.hasClass("active")
    $category_tabs = $(".category-tabs")
    $active_tab = $category_tabs.find("[data-filter].active")
    $active_tab.removeClass("active")
    $tab.addClass("active")
    #filter = $(this).attr("data-filter")
    #filter = "*" if filter == '.category-all'
    filter = build_filter()
    $isotope_grid.isotope({
      filter: filter
    })

build_filter = ()->
  practices_filter = $(".practices_select").val() || false
  practices_filter = false if practices_filter == '0'

  departments_filter = $(".departments_select").val() || false
  departments_filter = false if departments_filter == '0'
  console.log "departments_filter = 0 : ", departments_filter == '0'

  filter = []
  if practices_filter
    filter.push(".service-" + practices_filter)
  if departments_filter
    filter.push(".service-" + departments_filter)

  category_filter = $(".category-tabs [data-filter].active").attr("data-filter")
  if category_filter != '.category-all'
    filter.push(category_filter)


  if filter.length > 0
    filter = filter.join("")
  else
    filter = "*"

  console.log "filter: ", filter
  return filter

$("body").on "change", ".practices_select, .departments_select", ()->
  filter = build_filter()
  $isotope_grid.isotope({
    filter: filter
  })


$("body").on "change", ".projects_sorting_property_select, .sort-direction", ()->
  sort_property = $(".projects_sorting_property_select").val()
  asc = $("#filter_sorting_asc:checked").length == 1
  $isotope_grid.isotope({
    sortBy: sort_property
    sortAscending: asc
  })