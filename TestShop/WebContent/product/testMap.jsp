<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8" />

	
	<link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/dist/leaflet.css" integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ==" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js" integrity="sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og==" crossorigin=""></script>




<title>지도 테스트</title>


<style type="text/css">
#mapid { height: 180px; }

</style>


  </head>
  <body>
   

지도를 클릭해 위치를 지정하세요.
<div id="mapid" style="width: 600px; height: 400px;"></div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

	var mymap = L.map('mapid').setView([37.564, 127.0017], 13);
	

	L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
		maxZoom: 18,
		attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
			'<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
			'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
		id: 'mapbox.streets'
	}).addTo(mymap);
	
	var latlngs = [
		[37.540, 127.0050],
		[37.550, 127.0080],		
		[37.560, 127.0100]
	];
	var polyline = L.polyline(latlngs, {color: 'red'}).addTo(mymap);
	if(latlngs.length >=1){
		for (i=0;i<latlngs.length;i++){
	
			L.marker(latlngs[i]).addTo(mymap).bindPopup("<b>경로</b>");
	}}
	// zoom the map to the polyline
// 	mymap.fitBounds(polyline.getBounds());
	
	
	
	//팝업은 하나만 나옴
	
// 	L.marker([37.564, 127.00]).addTo(mymap).bindPopup("<b>지도</b>").openPopup();		//마커
	
	
	L.circle([37.545, 127.0017], {
		color: 'red',
		fillColor: '#f03',
		fillOpacity: 0.5,
		radius: 500
	}).addTo(mymap).bindPopup("<b>서울시 강남구 서초구</b>");				//원 
	
	L.polygon([
		[37.560, 127.0050],
		[37.570, 127.0080],		
		[37.570, 127.0050],		
		[37.560, 127.0020]
	]).addTo(mymap).bindPopup("<b>그냥 테스트</b>");			//다각형 폴리곤

	mymap.closePopup();
	var popup = L.popup();
	var theMarker = {};
	
 	mymap.on('click',function(e){
 		
	    lat = e.latlng.lat;
	    lon = e.latlng.lng;
	
	    if (theMarker != undefined) {
	    	mymap.removeLayer(theMarker);
	    	$( '#inputTest' ).val();
	    	console.log($( '#inputTest' ).val());
	    	$( '#inputTestTest' ).text(  ''  );
	    };
	
	    theMarker = L.marker([lat,lon]).addTo(mymap).bindPopup("<b>마커테스트</b>").openPopup();	
// 	    theMarker = L.marker([lat,lon]).addTo(mymap).bindPopup("<input id=\"inputTest\" type=\"text\" placeholder=\"입력하세요\" value=\"\">").openPopup();	
	    var tttttt = e.latlng.toString();
	    $( '#maptest' ).html(   tttttt   );
	    
	    $( "#inputTest" ).keyup(function( ) {
	    	$( '#inputTestTest' ).text(  $( '#inputTest' ).val()  );
	    });
	});

// 	function onMapClick(e) {

// 		var test = e.latlng.toString().substring(   (e.latlng.toString().indexOf("(")+1)  ,  e.latlng.toString().indexOf(")")  )

// 		popup
// 	        .setLatLng(e.latlng)
// 	        .setContent("여기 위도 경도 " + test )
// 	        .openOn(mymap);

// 		L.marker(e.latlng).addTo(mymap);
// 	}

	
// 	layerPointToLatLng(<Point> point)	LatLng	
// 	원점 픽셀을 기준으로 한 픽셀 좌표가 주어지면 해당 지리 좌표 (현재 확대 / 축소 수준)를 반환합니다.

// 	latLngToLayerPoint(<LatLng> latlng)	Point	
// 	지리적 좌표가 주어지면 원점 픽셀을 기준으로 해당 픽셀 좌표를 반환합니다 .

// click 	MouseEvent	사용자가지도를 클릭 (또는 탭) 할 때 발생합니다.
// dblclick 	MouseEvent	사용자가지도를 두 번 클릭 (또는 두 번 탭) 할 때 발생합니다.
// mousedown 	MouseEvent	사용자가지도에서 마우스 버튼을 누르면 발동됩니다.
// mouseup 	MouseEvent	사용자가지도에서 마우스 버튼을 놓을 때 발생합니다.

// 	mymap.on('click', onMapClick);

</script>

<span id="maptest">왜안돼</span>
<span id="inputTestTest"></span>

    
  </body>
</html>
