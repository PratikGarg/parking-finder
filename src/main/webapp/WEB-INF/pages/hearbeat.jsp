<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>Parking Finder</title>
<!--<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/c3.css" rel="stylesheet" type="text/css">

-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
<script>
var map;
var markers = [];

function getParkings(lat,lng){
      $.ajax({
      url : "http://api.sfpark.org/sfpark/rest/availabilityservice?lat="+lat+"&long="+lng+"&radius=1&uom=mile&response=json&type=off",
      success : function(data) {
        parkingdata = data;
        showParkings(parkingdata);
      },
      async : false,
      type : "GET",
      dataType : 'jsonp',
      jsonp : 'jsoncallback',
      jsonpCallback : "parseResponse",
      crossDomain : true,
      cache: true
    });
  
}

function showParkings(parkingdata){
  $.each(parkingdata.AVL,function(x,y){
    locations = y.LOC.split(",");
    var emptySlots = getEmptySlots(y);
   	var animation = "";
    
    if(emptySlots < 100) {
    	animation = google.maps.Animation.BOUNCE;
    }
    
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(locations[1], locations[0]),
      map: map,
      title: getParkingLotInfo(y.NAME, getAddress(y), emptySlots),
      animation: animation 
    });

    markers.push(marker);
  });

}


function clearMarkers() {
	for (var i = 0; i < markers.length; i++) {
	    markers[i].setMap(null);
	}
}
	
function getParkingLotInfo(name, address, emptySlots) {
	return name + "\n" + address + "\n" + "Empty Slots: " + emptySlots;
}

function getAddress(location) {
	return location.DESC + "\n" + location.INTER + "\nTel: " + location.TEL;
}

function getEmptySlots(location) {
	return parseInt(location.OPER) - parseInt(location.OCC);
}

function initialize() {
	var mapOptions = {
		zoom : 13,
		center : new google.maps.LatLng(37.7833, -122.4167),
		mapTypeId : google.maps.MapTypeId.ROADMAP,
		scrollwheel : false
	};

	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  google.maps.event.addListener(map, 'click', function(event) {
      map.setZoom(13);
      map.setCenter(event.latLng);
      clearMarkers();
      getParkings(event.latLng.k,event.latLng.D);
    });
}
google.maps.event.addDomListener(window, 'load', initialize);


</script>

</head>

<body>
	
<div id="map-canvas" style="height:800px"></div>
<div id="demo" name="demo"></div>
</body>
</html>