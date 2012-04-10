var geocoder;
var map;
var infowindow;
var markers = {};

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

    markers[curloc.post_id] = ( new google.maps.Marker({
      map: map,
      content: curloc.content,
      animation: google.maps.Animation.DROP,
      post_id: curloc.post_id,
      position: latlngloc}))

    bounds.extend( latlngloc )

    google.maps.event.addListener(markers[curloc.post_id], 'click',     selectPost);
    google.maps.event.addListener(markers[curloc.post_id], 'mouseover', highlightPost);
    google.maps.event.addListener(markers[curloc.post_id], 'mouseout',  unhighlightPost);
  }

  infowindow = new google.maps.InfoWindow();
  map.fitBounds( bounds )

  var selected_post_id = ''
  function selectPost(event) {
    infowindow.close();
    infowindow.setContent(this.content);
    infowindow.setPosition(event.latLng);
    infowindow.open(map);

    selected_post_id = this.post_id;

    // remove selected class from all other markers
    for( var m in markers ) {
      $("#post-teaser-" + m).removeClass("selected")
    }
    $("#post-teaser-" + this.post_id).addClass("selected");
    $.scrollTo("#post-teaser-" + this.post_id, {duration:1000, over: -0.5})
  }

  function highlightPost(event) {
    if( this.post_id != selected_post_id ) {
      $("#post-teaser-" + this.post_id).addClass("selected");
    }
  }

  function unhighlightPost(event) {
    if( this.post_id != selected_post_id ) {
      $("#post-teaser-" + this.post_id).removeClass("selected");
    }
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
