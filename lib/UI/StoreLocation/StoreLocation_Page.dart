import 'dart:convert';

import 'package:autofon_seller/UI/Map/UI/MapView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Profile_Service.dart';
import '../Map/Controller/Mapview_Service.dart';

class StoreLocationPage extends StatefulWidget {
  const StoreLocationPage({super.key});

  @override
  State<StoreLocationPage> createState() => _StoreLocationPageState();
}

class _StoreLocationPageState extends State<StoreLocationPage> {
  final profileAddress = Get.put(ProfileService());
  final mapview = Get.find<MapViewService>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<dynamic>(
          stream: profileAddress.instilize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text("Something went Wrong Please try again"));
            }
            final data = profileAddress.profileAddress.data?[0];
            final locationData = jsonDecode(data?.mapLocation ?? '{}');
            final lat = double.tryParse('${locationData['lat']}');
            final lng = double.tryParse('${locationData['lng']}');
            List<Widget> items = [
              Container(
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile Details",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              lineItems(
                  title: 'Address Name',
                  data: profileAddress.profileAddress.data?[0].addressName ??
                      'N/A'),
              lineItems(title: 'Party Name', data: data?.partyName ?? 'N/A'),
              lineItems(
                  title: 'Address Line 1',
                  data: profileAddress.profileAddress.data?[0].addressLine1 ??
                      'N/A'),
              lineItems(title: 'City', data: data?.city ?? 'N/A'),
              lineItems(title: 'District', data: data?.district ?? 'N/A'),
              lineItems(title: 'State', data: data?.state ?? 'N/A'),
              lineItems(title: 'Pincode', data: data?.pincode ?? 'N/A'),
              lineItems(title: 'Phone', data: data?.phone ?? 'N/A'),
              lineItems(title: 'GST Number', data: data?.gstNumber ?? 'N/A'),
              lineItems(title: 'Pan Number', data: data?.panNumber ?? 'N/A'),
              GetBuilder<MapViewService>(builder: (controller) {
                return (lat != null &&
                        lng != null &&
                        (mapview.lat.toString() != lat.toString() ||
                            mapview.lng.toString() != lng.toString()))
                    ? MaterialButton(
                        onPressed: () async {
                          await mapview.updateMapLocationUser(data?.id ?? '');
                          await profileAddress.setInstilize();
                          Get.snackbar(
                              'Success', 'Map Location Updated Successfully');
                        },
                        color: Theme.of(context).colorScheme.secondary,
                        child: Text('Save',
                            style: Theme.of(context).textTheme.bodySmall),
                      )
                    : SizedBox();
              }),
              MapView(
                pincode: data?.pincode ?? '',
                lat: lat ?? 0.0,
                lng: lng ?? 0.0,
              ),
            ];
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: items)));
          },
        ),
      ),
    );
  }

  lineItems({required String title, required String data}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          Expanded(
            child: Text(data),
          ),
        ],
      ),
    );
  }
}
