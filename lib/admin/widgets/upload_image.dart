// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/admin/admin.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/services/services.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class UploadFile extends StatelessWidget {
  const UploadFile({Key? key}) : super(key: key);

  static final AdminController _adminController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16).copyWith(top: 24),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8)
            .copyWith(left: _adminController.file == null ? 16 : 12),
        child: Row(
          children: [
            Obx(
              () => _adminController.file == null
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 100,
                      child: ClipRRect(
                        borderRadius: kSmallRadius,
                        child: Image.file(_adminController.file!),
                      ),
                    ),
            ),
            Obx(
              () => _adminController.file == null
                  ? Label(
                      'No file selected',
                      style: Get.textTheme.subtitle2,
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Label.primary(
                          _adminController.fileName,
                          style: Get.textTheme.subtitle2,
                        ),
                      ),
                    ),
            ),
            Obx(
              () => _adminController.file == null
                  ? const Spacer()
                  : const SizedBox.shrink(),
            ),
            Obx(
              () => Column(
                children: [
                  if (_adminController.file != null) ...[
                    Button(
                      label: 'Remove',
                      onTap: () => _adminController.file = null,
                      buttonColor: kErrorColor,
                    ),
                    const SizedBox(height: 8),
                  ],
                  Button(
                    label: _adminController.file == null ? 'Upload' : 'Change',
                    onTap: () async {
                      File? file = await DocumentService.getDocument();
                      if (file != null) {
                        _adminController.file = file;
                        _adminController.refresh();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
