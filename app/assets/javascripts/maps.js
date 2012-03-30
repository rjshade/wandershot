var geocoder;
var map;
var marker;

function gmaps_init(){
  // first we create a map object with some default configuration
  var latlng = new google.maps.LatLng(51.751724,-1.255284);
  var options = {
    zoom: 2,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
        
  map = new google.maps.Map(document.getElementById("map_canvas"), options);
        
  // the geocoder object allows us to do latlng lookup based on address
  geocoder = new google.maps.Geocoder();
        
  // the marker shows us the position of the latest address
  marker = new google.maps.Marker({
    map: map,
         draggable: true
  });
}

$(document).ready(function() { 
  gmaps_init();
  $(function() {
    // initialise jquery-ui autocomplete element
    $("#address").autocomplete({

      // source is the list of input options shown in the autocomplete dropdown.
      //
      // It can be a list of strings:
      //
      // [ "Choice1", "Choice2" ]
      //
      // an array of objects with label and value properties:
      //
      // [ { label: "Choice1", value: "value1" }, ... ]
      //
      // or a callback function which takes two parameters:
      //
      // function(request,response)
      //
      // The request parameter has one property, 'term' which contains the
      // value currently in the input box.
      //
      // The response parameter is a callback which expects a single argument
      // which is the list of data to present to the user (either list of strings
      // or array of label:value objects as described above).

      source: function(request,response) {

        // the geocode method takes an address to search for (can be a LatLng for
        // reverse lookup), and a callback function which should process the results
        //
        // inside the geocode results callback we populate the user input of the 
        // autocomplete box by calling the response callback declared by autocomplete
        geocoder.geocode( {'address': request.term }, function(results, status) {
          response($.map(results, function(item) {
            return {
              label:    item.formatted_address,
              value:    item.formatted_address,
              latitude: item.geometry.location.lat(),
              longitude:item.geometry.location.lng()
            }
          }));
        })
      },

      // event triggered when drop-down option selected
      select: function(event,ui){
        update_ui( ui.formatted_address, ui.item.latitude, ui.item.longitude )
        update_map( new google.maps.LatLng(ui.item.latitude, ui.item.longitude) )
      }
    });
  });

  // event triggered when marker is dragged and dropped
  google.maps.event.addListener(marker, 'dragend', function() {
    geocode_lookup( 'latLng', marker.getPosition() );
  });

  // event triggered when map is clicked
  google.maps.event.addListener(map, 'click', function(event) {
    marker.setPosition(event.latLng)
    geocode_lookup( 'latLng', event.latLng  );
  });

  // triggered when user presses a key in the address box
  $("#address").bind('keydown', function(event) {
    if(event.keyCode == 13) {
      geocode_lookup( 'address', $('#address').val(), true );

      // close the dropdown menu
      $('#address').autocomplete("close")
    }
  });

  // move the marker to a new position, and center the map on it
  function update_map( latLng ) {
    map.setCenter( latLng )
    map.setZoom( 16 )
    marker.setPosition( latLng )
  }

  // fill in the UI elements with new position data
  function update_ui( address, lat, lng ) {
    $('#address').autocomplete("close");
    $('#address').val(address);
    $('#latitude').html(lat);
    $('#longitude').html(lng);
  }

  // Query the Google geocode object
  //
  // type: 'address' for search by address
  //       'latLng'  for search by latLng (reverse lookup)
  //
  // value: search query
  //
  // update: should we update the map (center map and position marker)?
  function geocode_lookup( type, value, update ) {

    // default value: update_map = false
    update = typeof update !== 'undefined' ? update : false

    request = {}
    request[type] = value

    geocoder.geocode(request, function(results, status) {
      $('#map-search-error').html('');
      if (status == google.maps.GeocoderStatus.OK) {

        // Google geocoding has succeeded!

        if (results[0]) {

          // Always update the UI elements with new location data
          update_ui( results[0].formatted_address,
                     results[0].geometry.location.lat(),
                     results[0].geometry.location.lng() );
          
          // Only update the map (position marker and center map) if requested
          if( update ) {
            update_map( results[0].geometry.location )
          }

        } else {

          // Geocoder status ok but no results!?
          $('#map-search-error').html("Sorry! Something went wrong. Try again!");

        }

      } else {

        // Google Geocoding has failed. Two common reasons:
        //   * Address not recognised (e.g. search for 'zxxzcxczxcx')
        //   * Location doesn't map to address (e.g. click in middle of Atlantic)

        if( type == 'address' ) {
          // User has typed in an address which we can't geocode to a location
          $('#map-search-error').html("Sorry! We couldn't find " + value + ". Try a different search term, or click the map." );
        } else {
          // User has clicked or dragged marker to somewhere that Google can't do a reverse lookup for
          // In this case we display a warning, clear the address box, but fill in LatLng
          $('#map-search-error').html("Woah... that's pretty remote! You're going to have to manually enter a place name." );
          update_ui('', value.lat(), value.lng())
        }
      };
    });
  };
});
