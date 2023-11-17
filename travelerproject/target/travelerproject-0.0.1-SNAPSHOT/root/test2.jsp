<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="map" style="width: 100%; height: 500px;"></div>
	<input type="text" id="search-input" placeholder="検索キーワード">
	<button onclick="searchPlaces()">検索</button>
	<div id="place-details"></div>

	<!-- Google Maps JavaScript APIの読み込み -->
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD1yxfRrauIKcvTkc5iqB8fKQ-UMPw3E4g&callback=initMap&libraries=places"></script>

	<script>
    var map;
    var userLocation;

    function initMap() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                userLocation = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };

                map = new google.maps.Map(document.getElementById('map'), {
                    center: userLocation,
                    zoom: 17
                });
            });
        } else {
            alert('位置情報を取得できません。');
        }
    }

    function searchPlaces() {
        var keyword = document.getElementById('search-input').value;
        var service = new google.maps.places.PlacesService(map);

        service.textSearch({
            location: userLocation,
            radius: 5000,
            query: keyword
        }, function(results, status) {
            if (status === google.maps.places.PlacesServiceStatus.OK) {
                var place = results[0];  // 最初の検索結果を取得
                displayPlaceDetails(place.place_id);
            }
        });
    }

    function displayPlaceDetails(placeId) {
        var service = new google.maps.places.PlacesService(map);

        service.getDetails({
            placeId: placeId
        }, function(place, status) {
            if (status === google.maps.places.PlacesServiceStatus.OK) {
                var detailsDiv = document.getElementById('place-details');
                detailsDiv.innerHTML = '<h2>' + place.name + '</h2>' +
                    '<p>住所: ' + place.formatted_address + '</p>' +
                    '<p>写真: <img src="' + place.photos[0].getUrl({ maxWidth: 100, maxHeight: 100 }) + '"></p>' +
                    '<p>種類: ' + place.types[0] + '</p>' +
                    '<p>電話番号: ' + place.formatted_phone_number + '</p>' +
                    '<p>ウェブサイト: <a href="' + place.website + '" target="_blank">' + place.name + '</a></p>' +
                    '<p>営業時間: ' + place.opening_hours.weekday_text.join(', ') + '</p>' +
                    '<p>ユーザーの評価: ' + place.rating + '</p>';
            }
        });
    }

    </script>
</body>
</html>
