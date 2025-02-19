import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Controller/Inquiries_Service.dart';

class InquiriOperation extends StatefulWidget {
  VoidCallback function;
  InquiriOperation({super.key, required this.function});

  @override
  State<InquiriOperation> createState() => _InquiriOperationState();
}

class _InquiriOperationState extends State<InquiriOperation> {
  final inquirieServiceController = Get.find<InquirieService>();
  @override
  Widget build(BuildContext context) {
    final outline = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 3.5));
    return FloatingActionButton(
      onPressed: () {
        final textController = TextEditingController();
        String? selectedCategory;

        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("Inquiry"),
                        SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: InputDecoration(
                            label: Text('Category'),
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            focusedErrorBorder: outline,
                            focusedBorder: outline,
                            enabledBorder: outline,
                            errorBorder: outline,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          items: [
                            DropdownMenuItem(
                                value: 'Product request',
                                child: Text('Product request')),
                            DropdownMenuItem(
                                value: 'Feature request',
                                child: Text('Feature request')),
                            DropdownMenuItem(
                                value: 'Product update',
                                child: Text('Product update')),
                            DropdownMenuItem(
                                value: 'Feedback', child: Text('Feedback')),
                            DropdownMenuItem(
                                value: 'Others', child: Text('Others')),
                          ],
                          onChanged: (value) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          maxLines: 6,
                          controller: textController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            hintText: "Message",
                            focusedErrorBorder: outline,
                            focusedBorder: outline,
                            enabledBorder: outline,
                            errorBorder: outline,
                          ),
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: textController.text.isNotEmpty &&
                              selectedCategory != null
                          ? () {
                              inquirieServiceController.addInquirie(
                                  category: selectedCategory!,
                                  message: textController.text);
                              Get.back();
                              widget.function();
                            }
                          : () {},
                      color: textController.text.isNotEmpty &&
                              selectedCategory != null
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.tertiary,
                      child: Text(
                        'Create',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Get.back();
                      },
                      color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                );
              },
            );
          },
        );
      },
      child: Icon(FontAwesomeIcons.add),
    );
  }
}
