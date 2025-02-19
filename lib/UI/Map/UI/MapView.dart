import 'package:autofon_seller/Controller/EditProfile_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../Controller/Mapview_Service.dart';

class MapView extends StatefulWidget {
  dynamic lat;
  dynamic lng;
  String pincode;
  MapView({super.key, this.lng, this.lat, required this.pincode});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final mapviewService = Get.find<MapViewService>();

  bool isLoading = true;

  @override
  void initState() {
    instilize();
    super.initState();
  }

  instilize() async {
    if (widget.lng != null && widget.lng != null) {
      mapviewService.lat = (widget.lat as num).toDouble();
      mapviewService.lng = (widget.lng as num).toDouble();
      mapviewService.htmlContent(mapviewService.lat, mapviewService.lng);
      await mapviewService.updateMarkerPosition();
    } else {
      await mapviewService.markLocation(widget.pincode);
    }

    isLoading = false;
    setState(() {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Get.defaultDialog(
        title: "Enable Location",
        titleStyle: Theme.of(context).textTheme.bodyMedium,
        radius: 0,
        content: Column(
          spacing: 10,
          children: [
            Text(
              "Click Yes to Enable Location",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    Get.back();
                    return;
                  },
                  child:
                      Text("No", style: Theme.of(context).textTheme.bodySmall),
                ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () async {
                    await Geolocator.requestPermission();
                    await Geolocator.openLocationSettings();
                    serviceEnabled =
                        await Geolocator.isLocationServiceEnabled();

                    Get.back();
                  },
                  child:
                      Text("Yes", style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ),
          ],
        ),
      );

      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MaterialButton(
          onPressed: () async {
            var data = await _determinePosition();

            mapviewService.lat = data.latitude;
            mapviewService.lng = data.longitude;
            await mapviewService.updateMarkerPosition();
            Get.find<EditProfileService>().isLocationChange = true;
            Get.find<EditProfileService>().update();
            setState(() {});
          },
          color: Theme.of(context).colorScheme.secondary,
          child: Text('Set Current Location',
              style: Theme.of(context).textTheme.bodySmall),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : WebViewWidget(
                  controller: mapviewService.webcontroller,
                ),
        ),
      ],
    );
  }
}
