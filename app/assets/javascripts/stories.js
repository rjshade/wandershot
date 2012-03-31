var geocoder;
var map;
var marker;

// initialise the google maps objects, and add listeners
function gmaps_story_init(){

  // center of the universe
  var latlng = new google.maps.LatLng(51.751724,-1.255284);

  var options = {
    zoom: 2,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };

  // create our map object
  map = new google.maps.Map(document.getElementById("gmaps-story-view"), options);

  bounds = new google.maps.LatLngBounds()

  var locations = $('#gmaps-story-view').data('locations');
  for( loc in locations ) {
    curloc = locations[loc];
    latlngloc = new google.maps.LatLng( curloc.latitude, curloc.longitude )

    marker = new google.maps.Marker({
      map: map,
      position: latlngloc})

    bounds.extend( latlngloc )
  }

  map.fitBounds( bounds )
}

$(document).ready(function() { 
  if( $('#gmaps-story-view').length  ) {
    gmaps_story_init();
  }; 
});