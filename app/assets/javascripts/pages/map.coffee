initialize_google_map = ->

  $map = $("#contact-map")

  return if !$map.length
  lat = 43.660219
  lng = -79.489481

  latlng = new google.maps.LatLng(lat, lng)

  mapOptions =
    zoom: 17
    center: latlng
    scrollwheel: true




  map = new google.maps.Map($map.get(0), mapOptions)

  marker = new google.maps.Marker({
    map: map,
    draggable: true,
    animation: google.maps.Animation.DROP,
    position: {lat: lat, lng: lng}
  });

initialize_google_map()