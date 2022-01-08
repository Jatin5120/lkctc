// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lkctc_student_app/admin/admin.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/services/services.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class AddNoticesView extends StatelessWidget {
  AddNoticesView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final TextEditingController _titleController = TextEditingController();
  static final TextEditingController _descriptionController =
      TextEditingController();

  static final AdminController _adminController = Get.find();

  void _uploadNotice() async {
    if (_formKey.currentState!.validate()) {
      final String? imageUrl;
      bool shouldContinue = true;

      /// Handling condition if user has [Selected image] to upload
      if (_adminController.file != null) {
        final String name = DateTime.now().fileName;

        imageUrl = await FirebaseService.uploadFile(
          file: _adminController.file!,
          name: name,
          fileType: 'jpg',
          path: kNoticesFilePath,
        );

        if (imageUrl == null) {
          DialogService.showErrorDialog(
            title: 'Image not uploaded',
            message:
                'An error occurred while uploading the image. Kindly try again later. If the error still persists, contact the admin',
          );
          shouldContinue = false;
        }
      }

      /// Condition if user has [Not selected image] to upload
      else {
        imageUrl = '';
      }

      /// This condition will be true when -
      /// 1. User has selected an image to upload and it is uploaded to firestore.
      /// 2. User has not selected an image.
      if (shouldContinue) {
        final NoticeModal noticeModal = NoticeModal(
          noticeID: '',
          title: _titleController.text,
          description: _descriptionController.text,
          imageUrl: imageUrl!,
          date: DateTime.now().millisecondsSinceEpoch,
        );

        bool isAdded = await AdminService.addNotice(noticeModal);

        if (isAdded) {
          DialogService.showSuccessDialog(
            message: 'The notice has been added',
          );
          _titleController.text = '';
          _descriptionController.text = '';
          _adminController.file = null;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar('Add Notice'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: size.height.eightyPercent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField(
                    label: 'Title',
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "*Required";
                      return null;
                    },
                  ),
                  InputField(
                    label: 'Description',
                    controller: _descriptionController,
                    maxLines: 3,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "*Required";
                      return null;
                    },
                  ),
                  const _UploadFile(),
                  const Spacer(),
                  Button(
                    label: 'Upload Notice',
                    buttonSize: ButtonSize.large,
                    onTap: _uploadNotice,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UploadFile extends StatelessWidget {
  const _UploadFile({Key? key}) : super(key: key);

  static final AdminController _adminController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16).copyWith(top: 24),
      child: Padding(
        padding: const EdgeInsets.all(8)
            .copyWith(left: _adminController.file == null ? 16 : 12),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
