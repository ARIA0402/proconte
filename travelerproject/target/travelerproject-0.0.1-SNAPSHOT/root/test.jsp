<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Travel Planner</title>
<style>
#map {
	width: 100%;
	height: 400px;
}

#route-panel {
	width: 30%;
	height: 100%;
	position: absolute;
	top: 0;
	right: -30%;
	background: #fff;
	padding: 20px;
	box-shadow: -5px 0 5px -5px #333;
	transition: right 0.3s;
}

#route-toggle {
	position: absolute;
	top: 20px;
	right: 20px;
	cursor: pointer;
}
</style>
</head>
<body>
	<h1>Travel Planner</h1>

	<!-- スポット検索フォーム -->
	<form>
		<input type="text" id="searchInput" placeholder="スポットのキーワードを入力">
		<button type="button" onclick="searchSpots()">検索</button>
	</form>

	<!-- マップとルートパネルを表示 -->
	<div id="map"></div>
	<div id="route-panel">
		<h2>ルート</h2>
		<ul id="route-list">
			<!-- ルートに追加されたスポットが表示される -->
		</ul>
	</div>

	<div id="route-toggle" onclick="toggleRoutePanel()">開く/閉じる</div>

	<!-- スポット詳細情報表示 -->
	<div id="spotDetailsModal" class="modal">
		<div class="modal-content">
			<div id="spotDetailsContent">
				<!-- スポットの詳細情報がここに表示されます -->
			</div>
		</div>
	</div>

	<!-- Google Maps JavaScript APIの読み込み -->
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD1yxfRrauIKcvTkc5iqB8fKQ-UMPw3E4g&callback=initMap&libraries=places"></script>

	<script>
        var map;
        var markers = [];
        var route = [];

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: 0, lng: 0 }, // 初期位置 (ゼロ値はデフォルトで変更されます)
                zoom: 15 // ズームレベル
            });

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    var userLocation = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };
                    map.setCenter(userLocation);
                });
            }

            // マップ上でクリックしたときに詳細情報を表示
            map.addListener('click', function(event) {
                showSpotDetails(event.latLng);
            });
        }

        function searchSpots() {
            var searchInput = document.getElementById('searchInput').value;
            var request = {
                location: map.getCenter(),
                radius: 5000,
                query: searchInput
            };

            var service = new google.maps.places.PlacesService(map);
            service.textSearch(request, function (results, status) {
                if (status == google.maps.places.PlacesServiceStatus.OK) {
                    clearMarkers();
                    for (var i = 0; i < results.length; i++) {
                        createMarker(results[i]);
                    }
                }
            });
        }

        function createMarker(place) {
            var marker = new google.maps.Marker({
                map: map,
                position: place.geometry.location
            });
            markers.push(marker);

            marker.addListener('click', function() {
                showSpotDetails(place);
            });
        }

        function showSpotDetails(place) {
            var spotDetailsContent = document.getElementById('spotDetailsContent');
            spotDetailsContent.innerHTML += "<span class='close' onclick='closeSpotDetailsModal()'>&times;</span>"
            spotDetailsContent.innerHTML = "名前: " + place.name + "<br>住所: " + place.formatted_address;
            document.getElementById('spotDetailsModal').style.display = 'block';
            // スポットの詳細情報にルートに追加するボタンを追加
            spotDetailsContent.innerHTML += "<button onclick='addToRoute()'>ルートに追加</button>";
        }

        function addToRoute() {
            var spotDetailsContent = document.getElementById('spotDetailsContent');
            var spotDetails = spotDetailsContent.innerHTML;
            var routeList = document.getElementById('route-list');
            var listItem = document.createElement('li');
            listItem.innerHTML = spotDetails;
            routeList.appendChild(listItem);
        }

        function clearMarkers() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
        }

        function closeSpotDetailsModal() {
            document.getElementById('spotDetailsModal').style.display = 'none';
        }

        function toggleRoutePanel() {
            var routePanel = document.getElementById('route-panel');
            if (routePanel.style.right === '0%') {
                routePanel.style.right = '-30%';
                map.style.width = '100%';
            } else {
                routePanel.style.right = '0%';
                map.style.width = '70%';
            }
        }
    </script>
</body>
</html>