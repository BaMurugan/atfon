import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/DriverManagement_Service.dart';
import '../../Module/DeliverManagement_Module.dart';

import 'DriverOperation.dart';

class DriverManagementPage extends StatefulWidget {
  const DriverManagementPage({super.key});

  @override
  State<DriverManagementPage> createState() => _DriverManagementPageState();
}

class _DriverManagementPageState extends State<DriverManagementPage> {
  final driverController = Get.put(DriverManagementService());

  final scrollController = ScrollController();

  fetchData() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      driverController.fetchNextData();
    }
  }

  @override
  void initState() {
    scrollController.addListener(fetchData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const outline = OutlineInputBorder(
      borderSide:
          BorderSide(color: Colors.black, width: 3.5, style: BorderStyle.solid),
    );
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            Get.to(DriverOperation(title: 'Add New Delivery Person'));
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: driverController.instilize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text("Something went Wrong Please Try again"));
            }
            return GetBuilder<DriverManagementService>(
              builder: (_) {
                return Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Driver Management',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: TextField(
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                          suffixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                          labelText: "Search Delivery Person",
                          labelStyle: Theme.of(context).textTheme.titleSmall,
                          enabledBorder: outline,
                          focusedBorder: outline,
                        ),
                        onChanged: (value) async {
                          await driverController.searchPersons(search: value);
                        },
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          driverController.getData();
                        },
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: driverController.persons.length,
                          itemBuilder: (context, index) {
                            final item = driverController.persons[index];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 2),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 10,
                                      children: [
                                        itemRow(
                                            key: 'Name', value: item!.name!),
                                        itemRow(
                                            key: 'Phone Number',
                                            value: item.phoneNumber!),
                                        itemRow(
                                            key: 'Vehicle Number',
                                            value: item.vehicleNumber!),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    spacing: 20,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(DriverOperation(
                                            title: 'Edit Delivery Person',
                                            name: item.name,
                                            phoneNumber: item.phoneNumber,
                                            vehicleNumber: item.vehicleNumber,
                                            id: item.id,
                                          ));
                                        },
                                        child: Icon(FontAwesomeIcons.pen,
                                            color: Colors.grey),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await driverController
                                              .deleteDeliveryPerson(
                                                  id: item.id!);
                                          setState(() {});
                                        },
                                        child: Icon(FontAwesomeIcons.trashCan,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  itemRow({required String key, required String value}) {
    return Row(
      children: [
        Expanded(
          child: Text(key),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}
