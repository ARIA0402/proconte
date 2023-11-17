<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>とらべら～</title>
<style>
#map {
	height: 400px;
	width: 100%;
}
</style>
</head>
<body>
	<h1>Travel Planner</h1>

	<!-- Google Mapsを表示する要素 -->
	<div id="map"></div>

	<!-- スポット検索フォーム -->
	<form id="spotSearchForm">
		<input type="text" id="spotSearchInput" placeholder="スポットをキーワードで検索">
		<button type="submit">検索</button>
	</form>

	<!-- 検索結果表示 -->
	<ul id="searchResults"></ul>

	<!-- スポット詳細情報表示 -->
	<div id="spotDetailsModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeSpotDetailsModal()">&times;</span>
			<div id="spotDetailsContent">
				<!-- スポットの詳細情報がここに表示されます -->
			</div>
		</div>
	</div>

	<!-- Google Mapsの初期化とユーザーの現在地取得 -->
	<script>
        var map;
        var infowindow;

        function initMap() {
            // マップの初期設定
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: 0, lng: 0 }, // 初期位置 (ゼロ値はデフォルトで変更されます)
                zoom: 15 // ズームレベル
            });

            infowindow = new google.maps.InfoWindow();

            // ユーザーの現在地を取得
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    var userLocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    // マップをユーザーの現在地にセンタリング
                    map.setCenter(userLocation);
                });
            }

            // スポット検索フォームのサブミット時の処理
            document.getElementById('spotSearchForm').addEventListener('submit', function (event) {
                event.preventDefault();
                var keyword = document.getElementById('spotSearchInput').value;
                searchSpots(keyword);
            });
        }

        function searchSpots(keyword) {
            var service = new google.maps.places.PlacesService(map);
            var request = {
                location: map.getCenter(),
                radius: 1000, // 半径1000メートル内で検索
                query: keyword
            };

            service.textSearch(request, function (results, status) {
                if (status == google.maps.places.PlacesServiceStatus.OK) {
                    displaySearchResults(results);
                }
            });
        }

        function displaySearchResults(results) {
            var searchResults = document.getElementById('searchResults');
            searchResults.innerHTML = '';

            results.forEach(function (spot) {
                var li = document.createElement('li');
                li.innerHTML = '<a href="javascript:void(0);" onclick="showSpotDetails(\'' + spot.place_id + '\')">' + spot.name + '</a>';
                searchResults.appendChild(li);
            });
        }

        function showSpotDetails(spotPlaceId) {
            var service = new google.maps.places.PlacesService(map);
            var request = {
                placeId: spotPlaceId
            };

            service.getDetails(request, function(place, status) {
                if (status === google.maps.places.PlacesServiceStatus.OK) {
                    // スポットの詳細情報をHTMLに表示
                    var spotDetailsContent = document.getElementById('spotDetailsContent');
                    spotDetailsContent.innerHTML = "名前: " + place.name + "<br>住所: " + place.formatted_address;
                    document.getElementById('spotDetailsModal').style.display = 'block';
                }
            });
        }

        function closeSpotDetailsModal() {
            document.getElementById('spotDetailsModal').style.display = 'none';
        }
    </script>

	<!-- Google Maps JavaScript APIの読み込み -->
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD1yxfRrauIKcvTkc5iqB8fKQ-UMPw3E4g&callback=initMap&libraries=places"></script>
</body>
</html>
