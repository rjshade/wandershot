var geocoder;
var map;
var marker;
var infowindow;

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
      content: curloc.content,
      animation: google.maps.Animation.DROP,
      post_id: curloc.post_id,
      position: latlngloc})

    bounds.extend( latlngloc )

    google.maps.event.addListener(marker, 'click', showPostInfo);
    google.maps.event.addListener(marker, 'mouseover', highlightTeaser);
  }

  infowindow = new google.maps.InfoWindow();
  map.fitBounds( bounds )

  function highlightTeaser(event) {
    $('#post-teaser-' + this.post_id).effect("highlight", {color: '#ccc'}, 500);
  }

  function showPostInfo(event) {
    infowindow.close();
    infowindow.setContent(this.content);
    infowindow.setPosition(event.latLng);
    infowindow.open(map);
    //$("#post-teaser-" + this.post_id).toggleClass("selected");
  }

  if( $(document).width() >= 800 ) {
    var elem = $('#gmaps-story-view')
    var top = elem.offset().top - parseFloat(elem.css('marginTop').replace(/auto/,0));
    $('#gmaps-story-view').css('height', $(window).height() - top - 40);
  }
}

$(document).ready(function() { 
  if( $('#gmaps-story-view').length  ) {
    gmaps_story_init();
  }; 
});
