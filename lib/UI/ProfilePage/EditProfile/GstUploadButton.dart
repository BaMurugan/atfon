import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/EditProfile_Service.dart';

class GstUploadButton extends StatefulWidget {
  const GstUploadButton({super.key});

  @override
  State<GstUploadButton> createState() => _GstUploadButtonState();
}

class _GstUploadButtonState extends State<GstUploadButton> {
  final editProfileService = Get.find<EditProfileService>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('GST Document ID'),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          if (editProfileService.pdfGstFile != null)
            Text('${editProfileService.pdfGstFile?.name}',
                style: Theme.of(context).textTheme.bodySmall),
          MaterialButton(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );

              if (result == null || result.files.isEmpty) return;

              editProfileService.pdfGstFile = result.files.first;
              editProfileService.update();
            },
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Choose File',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ])
      ],
    );
  }
}
