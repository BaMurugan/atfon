import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../Controller/EditProfile_Service.dart';

import '../../Map/Controller/Mapview_Service.dart';
import '../../Map/UI/MapView.dart';
import 'GstUploadButton.dart';
import 'PanUploadButton.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final editprofileService = Get.put(EditProfileService());

  bool verified = false;

  @override
  void initState() {
    editprofileService.instilize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(width: 3.5),
    );
    textField(
        {required String label,
        List<TextInputFormatter>? inputFormatters,
        Function(String)? onChanged,
        Widget? suffixIcon,
        String? Function(String?)? validator,
        TextInputType? keyboardType,
        required TextEditingController controller,
        bool? filled = false,
        bool readOnly = true}) {
      return TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        readOnly: readOnly,
        style: Theme.of(context).textTheme.bodySmall,
        inputFormatters: inputFormatters,
        enabled: !readOnly,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          enabledBorder: outline,
          errorBorder: outline,
          focusedErrorBorder: outline,
          disabledBorder: outline,
          filled: filled,
          fillColor: Theme.of(context).colorScheme.tertiary,
          focusedBorder: outline,
        ),
        onChanged: onChanged,
        validator: validator,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Edit Profile",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: GetBuilder<EditProfileService>(builder: (_) {
          String? mapLocation =
              editprofileService.profileAddress.data != null &&
                      editprofileService.profileAddress.data!.isNotEmpty
                  ? editprofileService.profileAddress.data![0].mapLocation
                  : null;

          Map<String, dynamic> locationData;
          try {
            locationData = mapLocation != null
                ? jsonDecode(mapLocation)
                : {'lat': '20.5937', 'lng': '78.9629'};
          } catch (e) {
            locationData = {'lat': '20.5937', 'lng': '78.9629'};
          }

          double lat =
              double.tryParse(locationData['lat'].toString()) ?? 20.5937;
          double lng =
              double.tryParse(locationData['lng'].toString()) ?? 78.9629;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  textField(
                    label: 'GST Number',
                    readOnly: true,
                    filled: true,
                    controller: editprofileService.gstNumberController,
                  ),
                  MaterialButton(
                    onPressed: () {
                      print((editprofileService.mapviewservice.lng !=
                              double.tryParse(jsonDecode(editprofileService
                                      .profileAddress
                                      .data![0]
                                      .mapLocation!)['lng']
                                  .toString()) ||
                          editprofileService.mapviewservice.lat !=
                              double.tryParse(jsonDecode(editprofileService
                                      .profileAddress
                                      .data![0]
                                      .mapLocation!)['lat']
                                  .toString())));
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    child: Text('Verified',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  editprofileService.enableDropDown
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text('Select a location'),
                            value: editprofileService.gstAddresses.isEmpty
                                ? null
                                : editprofileService.selectedAddressIndex,
                            items: List.generate(
                              editprofileService.gstAddresses.length,
                              (index) {
                                final indexAddress =
                                    editprofileService.gstAddresses[index];
                                final List<String> addressParts = [
                                  indexAddress.floorNumber,
                                  indexAddress.buildingNumber,
                                  indexAddress.buildingName,
                                  indexAddress.street,
                                  indexAddress.location,
                                  '${indexAddress.state}-${indexAddress.pincode}'
                                ];

                                // Filter out empty fields
                                final formattedAddress = addressParts
                                    .where((part) => part.trim().isNotEmpty)
                                    .join(', ');

                                return DropdownMenuItem(
                                  value: index,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(formattedAddress,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                );
                              },
                            ),
                            onChanged: (value) {
                              editprofileService.selectedAddressIndex = value!;
                              editprofileService.updateField(
                                  editprofileService.selectedAddressIndex);
                              editprofileService.enableDropDown = false;
                              editprofileService.update();
                            },
                          ),
                        )
                      : SizedBox(),
                  textField(
                      label: 'Address Name',
                      readOnly: false,
                      controller: editprofileService.addressNameController),
                  textField(
                      label: 'Party Name',
                      controller: editprofileService.partyNameController),
                  textField(
                      label: 'Address Line 1',
                      controller: editprofileService.addressLineOneController),
                  textField(
                      label: 'Address Line 2',
                      controller: editprofileService.addressLineTwoController),
                  textField(
                      label: 'City',
                      controller: editprofileService.cityController),
                  textField(
                      label: 'District',
                      controller: editprofileService.districtController),
                  textField(
                      label: 'State',
                      controller: editprofileService.stateController),
                  textField(
                      label: 'Pincode',
                      controller: editprofileService.pinCodeController),
                  textField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    label: 'Phone Number',
                    readOnly: true,
                    filled: true,
                    validator: (p0) {
                      if (p0!.isNotEmpty) {
                        if (p0.trim().length != 10) {
                          return 'Please Enter the Valid Phone Number';
                        }
                      }
                      return null;
                    },
                    controller: editprofileService.phoneNumberController,
                  ),
                  textField(
                      label: 'PAN Number',
                      controller: editprofileService.panNumberController),
                  GstUploadButton(),
                  PanUploadButton(),
                  textField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    label: 'Alternative Phone One',
                    readOnly: false,
                    validator: (p0) {
                      if (p0!.isNotEmpty) {
                        if (p0.trim().length != 10) {
                          return 'Please Enter the Valid Alternative Phone Number';
                        }
                      }
                      return null;
                    },
                    controller:
                        editprofileService.alternativePhoneNumberOneController,
                    onChanged: (p0) {
                      editprofileService.update();
                    },
                  ),
                  textField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      keyboardType: TextInputType.number,
                      label: 'Alternative Phone Two',
                      readOnly: false,
                      validator: (p0) {
                        if (p0!.isNotEmpty) {
                          if (p0.trim().length != 10) {
                            return 'Please Enter the Valid Alternative Phone Number';
                          }
                        }
                        return null;
                      },
                      onChanged: (p0) {
                        editprofileService.update();
                      },
                      controller: editprofileService
                          .alternativePhoneNumberTwoController),
                  MapView(
                      pincode: editprofileService.pinCodeController.text,
                      lat: lat,
                      lng: lng),
                  MaterialButton(
                    onPressed: (editprofileService.isLocationChange ||
                            (editprofileService
                                        .alternativePhoneNumberOneController
                                        .text !=
                                    editprofileService.profileService.user.data
                                        ?.alternatePhoneOne ||
                                editprofileService
                                        .alternativePhoneNumberTwoController
                                        .text !=
                                    editprofileService.profileService.user.data
                                        ?.alternatePhoneTwo))
                        ? () async {
                            try {
                              await editprofileService.saveUpdate();
                              await editprofileService.mapviewservice
                                  .updateMapLocationUser(editprofileService
                                      .profileAddress.data![0].id!);
                              Get.back();
                            } catch (e) {
                              Get.snackbar('Error', e.toString());
                            }
                          }
                        : () {},
                    color: (editprofileService.isLocationChange ||
                            (editprofileService
                                        .alternativePhoneNumberOneController
                                        .text !=
                                    editprofileService.profileService.user.data
                                        ?.alternatePhoneOne ||
                                editprofileService
                                        .alternativePhoneNumberTwoController
                                        .text !=
                                    editprofileService.profileService.user.data
                                        ?.alternatePhoneTwo))
                        ? Theme.of(context)
                            .colorScheme
                            .secondary // Change color when marker moves
                        : Theme.of(context).colorScheme.tertiary,
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
