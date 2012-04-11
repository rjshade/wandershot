var geocoder;
var map;
var infowindow;
var markers = {};
var markersHighlight = {};
var circles = {};
var selected_id = null;
var largeMap = false; // are we on large map page, or story page?

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

  var pinColor = "04bfbf";
  var pinColorHighlight = "f7e967";
  var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
      new google.maps.Size(21, 34),
      new google.maps.Point(0,0),
      new google.maps.Point(10, 34));
  var pinImageHighlight = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColorHighlight,
      new google.maps.Size(21, 34),
      new google.maps.Point(0,0),
      new google.maps.Point(10, 34));
  var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
      new google.maps.Size(40, 37),
      new google.maps.Point(0, 0),
      new google.maps.Point(12, 35));

  var locations = $('#gmaps-story-view').data('locations');
  var pathCoordinates = [];
  var prev_post_id = null;
  var next_post_id = null;
  var first_post_id = null;

  if( locations.length ){ first_post_id = locations[0].post_id };


  //for( loc in locations ) {
  for( var i = 0; i < locations.length; i++ ) {
    curloc = locations[i];

    // if we're in the middle of a list of locations then we want to record
    // prev/next post_ids so we can navigate through them. We need to do this
    // as we're storing markers etc. in hash maps keyed by post_id,
    // so we can't find prev/next by array indices
    if( i > 0 ){ prev_post_id = cur_post_id; }
    cur_post_id = curloc.post_id;
    if( i < (locations.length - 1) ) {
      next_post_id = locations[i+1].post_id;
    } else {
      next_post_id = null;
    }

    latlngloc = new google.maps.LatLng( curloc.latitude, curloc.longitude )
    markers[cur_post_id] = ( new google.maps.Marker({
      map: map,
      content: curloc.content,
      post_link: curloc.post_link,
      post_id: cur_post_id,
      prev_post_id: prev_post_id,
      next_post_id: next_post_id,
      position: latlngloc,
      icon: pinImage,
      shadow: pinShadow
    }))

    markersHighlight[cur_post_id] = ( new google.maps.Marker({
      map: map,
      post_id: cur_post_id,
      position: latlngloc,
      visible: false,
      icon: pinImageHighlight,
      shadow: pinShadow
    }))

    pathCoordinates.push( latlngloc );

    bounds.extend( latlngloc )

    $('.post.teaser#post-id-'+curloc.post_id).bind('click', postClickHandler)
    $('.post.teaser#post-id-'+curloc.post_id).bind('hover', postHoverHandler)

    google.maps.event.addListener(markers[curloc.post_id], 'click',     markerClickHandler);
    google.maps.event.addListener(markers[curloc.post_id], 'mouseover', highlightPost);
    google.maps.event.addListener(markers[curloc.post_id], 'mouseout',  unhighlightPost);
    google.maps.event.addListener(map, 'click',  function() { infowindow.close() });
  }


  var flightPath = new google.maps.Polyline({
    path: pathCoordinates,
    strokeColor: "#CAFCD8",
    strokeOpacity: 0.6,
    strokeWeight: 3
  });

  flightPath.setMap(map);
  infowindow = new google.maps.InfoWindow()
  map.fitBounds( bounds );

  $('.map-controls').find('.prev').children('a').attr( 'href', null )
  $('.map-controls').find('.next').children('a').attr( 'href', null )
  $('.map-controls').find('.prev').bind( 'click', selectPrevMarker )
  $('.map-controls').find('.next').bind( 'click', selectNextMarker )

  var originalZoom = map.getZoom();

  var selected_post_id = ''

  function markerClickHandler( event ) {
    selectPost( this.post_id );
  }

  function selectPost( post_id ) {
    var selectedMarker = markers[post_id];

    // on the large map page we want to display info windows
    // whereas on the story page we scroll to and highlight
    // the post teaser
    if( largeMap ) {
      infowindow.close();
      infowindow.setContent(selectedMarker.content);
      infowindow.setPosition(selectedMarker.getPosition());
      infowindow.open(map);
    } else {
      // remove selected class from all post teasers
      for( var m in markers ) {
        $('.post.teaser').removeClass("selected")
      }
      // but apply it to the current one
      $('.post.teaser#post-id-' + post_id).addClass('selected');

      // and scroll the page to the appropriate teaser
      $.scrollTo(".post.teaser#post-id-" + post_id, {duration:750, over: -0.5})
    }

    zoomMapTo( selectedMarker );

    // set all other markers to be not highlighted
    for( var m in markers ) {
      markers[m].setVisible(true);
      markersHighlight[m].setVisible(false);
    }

    // and this marker to be highlighted
    markers[post_id].setVisible(false)
    markersHighlight[post_id].setVisible(true)

    // remember which marker/post is selected
    selected_id = post_id;

    // make prev/next controls visible
    $('.map-controls').show();

    $('.map-controls').find('.middle').html( selectedMarker.post_link )

    // but disable controls appropriately
    if( selectedMarker.prev_post_id != null ) {
      $('.map-controls').find('.prev').removeClass('disabled');
    } else {
      $('.map-controls').find('.prev').addClass('disabled');
    }
    if( selectedMarker.next_post_id != null ) {
      $('.map-controls').find('.next').removeClass('disabled');
    } else {
      $('.map-controls').find('.next').addClass('disabled');
    }
  }

  function selectPrevMarker(event) {
    marker = markers[selected_id]; 
    if( marker.prev_post_id != null ) {
      selectPost( marker.prev_post_id );
    }
  }
 
  function selectNextMarker(event) {
    if( selected_id === null ) {
      // select the first marker
      selectPost( first_post_id );
    } else {
      marker = markers[selected_id]; 
      if( marker.next_post_id != null ) {
        selectPost( marker.next_post_id );
      }
    }
  }

  // hovering over the google maps marker should give the same effect
  // as hovering over the post teasers themselves
  function highlightPost(event) {
    if( this.post_id != selected_post_id ) {
      $(".post.teaser#post-id-" + this.post_id).addClass("hovering");
    }
  }

  function unhighlightPost(event) {
    if( this.post_id != selected_post_id ) {
      $(".post.teaser#post-id-" + this.post_id).removeClass("hovering");
    }
  }

  function postHoverHandler(event) {
    // toggle visibility of map marker highlight
    toggleMarkerHighlight( $(this).data('post-id') );
  }

  function toggleMarkerHighlight( marker_id ) {
    // don't want to toggle highlighting of selected marker
    if( marker_id != selected_id ) {
      marker = markers[marker_id]
      markerHighlight = markersHighlight[marker_id]
      
      marker.setVisible( !marker.getVisible() );
      markerHighlight.setVisible( !markerHighlight.getVisible() );
    }
  }

  function postClickHandler(event) {
    selectPost( $(this).data('post-id') )
  }

  function zoomMapTo( marker ) {
    // move map to marker
    map.panTo(marker.getPosition());

    // zoom in on marker
    var newZoom = originalZoom + 1;
    if( newZoom <= 16 ){ map.setZoom( newZoom ); }
  }

  if( $(document).width() >= 800 ) {
    var elem = $('#gmaps-story-view')
    var top = elem.offset().top - parseFloat(elem.css('marginTop').replace(/auto/,0));
    $('#gmaps-story-view').css('height', $(window).height() - top - 200);
  }

  $(document).keydown(function (evt) {
    if( evt.keyCode === 39 || evt.keyCode === 40 ) {
      selectNextMarker();
    }
    if( evt.keyCode === 37 || evt.keyCode === 38 ) {
      selectPrevMarker();
    }
  });
}

$(document).ready(function() { 
  if( $('#gmaps-story-view').length  ) {
    largeMap = $('.large-map').length;

    gmaps_story_init();
  }; 
});
