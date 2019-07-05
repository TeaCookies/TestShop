<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>분양가능지역 테스트</title>
    
    
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  	<script type="text/javascript">
  	$(function() {
		  $( "button" ).on("click" , function() {
			
			  alert( $('#pop').text().trim() );
		  });
  	});
  </script>
    
  </head>
 
 
  <body>
  

    <div id="map" style="width: 600px; height: 400px;" title="지도"></div>

	
    <script>


      var map;
      var markers = [];

      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
	        zoom: 13,
	        center: {lat: 37.564, lng:  127.0017} 
        });

        map.addListener('click', addLatLng);
      }

      
      function addLatLng(event) {
    		$( '#maptest' ).html(  event.latLng.toString()   );
// 	        var infowindow = new google.maps.InfoWindow();

	        if (markers.length <3){
		        var marker = new google.maps.Marker({
			        position: event.latLng,
			        map: map
		        });
		        markers.push(marker);
		        $( "#pop ").append(  event.latLng.toString()+"#<br>"  );
		        
// 		        var upup = " <input type=\"text\" id=\"marker\" placeholder=\"지역입력\">"
// 		        infowindow.setContent(upup);
		        
// 	 	        infowindow.setContent("여기");
// 		        infowindow.open(map, marker);
// 		        $("#pop").text(infowindow.getContent());
// 		        $("#pop").text(  $( '#marker' ).val() );
		        
	        }else{
	        	alert("3개까지 지정 가능함");
	        }
	      
	        

	        if (marker != undefined){
	        	
	            marker.addListener('rightclick', function() {
	            	
					for (var i = 0; i < markers.length; i++) {
				       if (markers[i] === marker) {
				           markers[i].setMap(null);
				           markers.splice(i, 1 );
				           
				       }
			 	  	}
	            });
	        }
      }
      
      
      
      
    </script>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDaDu7bjQpGLN3nKnUfulB3khHE-iGQap0&callback=initMap"
    async defer></script>
    
    <span>우클릭으로 마커를 해제하세요.<br></span>
    <span id="pop"></span>
    <button type="button" class="btn btn-primary">등록</button>
    <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="내용을 입력하세요." readonly>
  </body>
</html>
