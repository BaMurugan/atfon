import 'package:autofon_seller/Module/Area_Module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/AreaManagemet_Service.dart';
import 'PincodeManagement.dart';
import '../../Module/ServiceArea_Module.dart';

class AddArea extends StatefulWidget {
  VoidCallback action;
  Datum? item;
  AddArea({super.key, required this.action, this.item});

  @override
  State<AddArea> createState() => _AddAreaState();
}

class _AddAreaState extends State<AddArea> {
  final areaManagementController = Get.find<AreaManagementService>();
  final formKey = GlobalKey<FormState>();
  TextEditingController searchArea = TextEditingController();
  TextEditingController text = TextEditingController();
  @override
  void initState() {
    if (widget.item != null) {
      text.text = widget.item!.name!;
      areaManagementController.selectedPincode = widget.item!.serviceableAreas!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const outline = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.5),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Add New Service Area',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: StreamBuilder(
          stream: widget.item != null
              ? areaManagementController.getEditingData(widget.item)
              : areaManagementController.instilize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            return GetBuilder<AreaManagementService>(
              builder: (_) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: text,
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                                labelText: "Service Area Name",
                                labelStyle:
                                    Theme.of(context).textTheme.bodySmall,
                                enabledBorder: outline,
                                focusedBorder: outline,
                                errorBorder: outline,
                                focusedErrorBorder: outline),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the Area Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        TextFormField(
                          controller: searchArea,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            labelText: "Search Service Area",
                            labelStyle: Theme.of(context).textTheme.bodySmall,
                            enabledBorder: outline,
                            focusedBorder: outline,
                            errorBorder: outline,
                            focusedErrorBorder: outline,
                          ),
                          onChanged: (value) async {
                            areaManagementController.query = value;
                            await areaManagementController.getPincodes();
                          },
                        ),
                        DropdownButton<String>(
                            value: areaManagementController.allStates
                                    .contains(areaManagementController.state)
                                ? areaManagementController.state
                                : null,
                            isExpanded: true,
                            items: areaManagementController.allStates
                                .toSet()
                                .map((state) {
                              return DropdownMenuItem<String>(
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
                            onChanged: (value) async {
                              areaManagementController.state = value;
                              areaManagementController.district = null;
                              areaManagementController.query = '';
                              await areaManagementController
                                  .getAllDropDownData();
                              areaManagementController.update();
                            },
                            hint: Text("Select a State")),
                        DropdownButton<String>(
                          value: areaManagementController.district,
                          isExpanded: true,
                          items: areaManagementController.allDistrict
                              .map((e) => DropdownMenuItem<String>(
                                  value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) async {
                            areaManagementController.district = value;
                            await areaManagementController.getAllDropDownData();
                            areaManagementController.query = '';
                            areaManagementController.update();
                          },
                          hint: Text("Select a District"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: PincodeManagement(),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (areaManagementController
                                  .selectedPincode.isEmpty) {
                                Get.snackbar('Error', 'Select Pincode');
                              }
                              if (areaManagementController
                                  .selectedPincode.isNotEmpty) {
                                if (widget.item == null) {
                                  await areaManagementController
                                      .saveAll(text.text);
                                } else {
                                  await areaManagementController.saveAll(
                                      text.text,
                                      id: widget.item?.id,
                                      isEdit: true);
                                }
                                Get.back();
                              }
                            }
                          },
                          color: Theme.of(context).colorScheme.secondary,
                          child: Text(
                            'Save',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
