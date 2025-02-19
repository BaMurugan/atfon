import 'dart:convert';

import 'package:autofon_seller/Controller/Profile_Service.dart';
import 'package:autofon_seller/Other%20Service/ApiPath.dart';
import 'package:autofon_seller/Other%20Service/ApiService.dart';
import 'package:autofon_seller/Other%20Service/HiveStoreage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../Controller/EditProfile_Service.dart';

class MapViewService extends GetxController {
  late WebViewController webcontroller;

  double lat = 0.0;
  double lng = 0.0;

  String htmlContent(double latitude, double longitude) {
    return '''
    <html>
  <head>
    <title>Place Marker on Click</title>
    <meta name="viewport" content="initial-scale=1.0" />
    <meta charset="utf-8" />
    <style>
      html,
      body,
      #map {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100vh;
      }
    </style>
    <script
      src="https://apis.mappls.com/advancedmaps/api/2e8dd15d1728e02d2c12e8c9a98af0f9/map_sdk?layer=vector&v=3.0&callback=initMap"
      defer
      async
    ></script>
  </head>
  <body>
    <div id="map"></div>
    <script>
      let map, marker;
      let latitude = ${latitude ?? 28.6139}; // Default latitude (example: Delhi)
      let longitude = ${longitude ?? 77.209}; // Default longitude (example: Delhi)

      
      function initMap() {
        // Initialize the map
        map = new mappls.Map("map", {
          center: [$longitude, $latitude],
          zoomControl: true,
          location: true,
          disableDoubleClickZoom: false,
          maxZoom: 15,
        });

        // Create an initial marker
        marker = new mappls.Marker({
          map: map,
          position: {
            lat: $latitude,
            lng: $longitude,
          },
          fitbounds: true,
        });

        // Add click event listener to the map
        map.on("click", function (event) {
          if (event.lngLat) {
            latitude = event.lngLat.lat;
            longitude = event.lngLat.lng;
            marker.setLngLat([longitude, latitude]);

            // Send the updated coordinates to Flutter
            if (window.flutter_inappwebview) {
              window.flutter_inappwebview.postMessage(
                JSON.stringify({ lat: latitude, lng: longitude })
              );
            }
          }
        });

        function updateMarkerPosition(lat, lng) {
          latitude = lat;
          longitude = lng;
          if (marker) {
            marker.setLngLat([longitude, latitude]);
          }
        }
      }
    </script>
  </body>
</html>

    ''';
  }

  updateMarkerPosition() async {
    webcontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'flutter_inappwebview',
        onMessageReceived: (JavaScriptMessage message) {
          final Map<String, dynamic> data = json.decode(message.message);

          lat = double.parse(data['lat'].toString());
          lng = double.parse(data['lng'].toString());
          if (Get.isRegistered<EditProfileService>()) {
            Get.find<EditProfileService>().isLocationChange = true;
            Get.find<EditProfileService>().update();
          }
          print('lat lng from MAp : $lat $lng');
          update();
        },
      )
      ..loadHtmlString(htmlContent(lat, lng));

    update();
  }

  markLocation(dynamic pincode) async {
    final data = await http.get(Uri.parse('${ApiPaths.sellerMap}${pincode}'),
        headers: {'Access-Control-Allow-Origin': '*'});

    Map latLng = jsonDecode(data.body);

    Map record = latLng['records'][0];
    lat = double.parse(record['latitude']);
    lng = double.parse(record['longitude']);

    await updateMarkerPosition();
  }

  updateMapLocationUser(String id) {
    final request = ApiService.call(
        apiCallMethod: ApiCallMethod.put,
        path: '${ApiPaths.userAddress}${ApiPaths.sellerUpdateMapLocation}',
        token: HiveService.getAuthToken(),
        body: {
          'mapLocation': jsonEncode({'lng': '$lng', 'lat': '$lat'}),
          'userAddressId': id,
        });
  }
}
