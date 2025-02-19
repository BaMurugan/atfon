import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Controller/EditProfile_Service.dart';

class PanUploadButton extends StatefulWidget {
  const PanUploadButton({super.key});

  @override
  State<PanUploadButton> createState() => _PanUploadButtonState();
}

class _PanUploadButtonState extends State<PanUploadButton> {
  final editProfileService = Get.find<EditProfileService>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('PAN Document ID'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (editProfileService.pdfPanFile != null)
              Text('${editProfileService.pdfPanFile?.name}',
                  style: Theme.of(context).textTheme.bodySmall),
            MaterialButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result == null || result.files.isEmpty) return;
                print(result.files);
                editProfileService.pdfPanFile = result.files.first;
                editProfileService.update();
              },
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                'Choose File',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        )
      ],
    );
  }
}
