// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/admin/admin.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/services/services.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class AddEventsView extends StatelessWidget {
  const AddEventsView({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _registrationController =
      TextEditingController();
  static final TextEditingController _submissionController =
      TextEditingController();
  static final TextEditingController _descriptionController =
      TextEditingController();

  static final AdminController _adminController = Get.find();

  void _createEvent() async {
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
          path: kEventsFilePath,
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
        final EventModal eventModal = EventModal(
          evendID: '',
          name: _nameController.text,
          description: _descriptionController.text,
          lastDate: _adminController.lastDate.millisecondsSinceEpoch,
          registerationLink: _registrationController.text,
          submissionLink: _submissionController.text,
          imageUrl: imageUrl!,
        );

        bool isAdded = await AdminService.createNotice(eventModal);

        if (isAdded) {
          DialogService.showSuccessDialog(
            message: 'The Event has been created',
          );
          _nameController.text = '';
          _descriptionController.text = '';
          _registrationController.text = '';
          _submissionController.text = '';
          _adminController.file = null;
          _adminController.lastDate = DateTime.now();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar('Add Event'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                  label: 'Event Name',
                  controller: _nameController,
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
                InputField(
                  label: 'Registration Link',
                  controller: _registrationController,
                  textCapitalization: TextCapitalization.none,
                ),
                InputField(
                  label: 'Submission Link',
                  controller: _submissionController,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.none,
                ),
                const UploadFile(),
                const _LastDateButton(),
                SizedBox(height: size.height.tenPercent),
                Button(
                  label: 'Create Event',
                  buttonSize: ButtonSize.large,
                  onTap: _createEvent,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LastDateButton extends StatelessWidget {
  const _LastDateButton({Key? key}) : super(key: key);

  static final AdminController _adminController = Get.find();
  static final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputLabel('Last Date'),
        TapHandler(
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: _adminController.lastDate,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            _adminController.lastDate = date ?? _adminController.lastDate;
          },
          child: Card(
            margin: const EdgeInsets.only(top: 0),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today_rounded),
                  const SizedBox(width: 16),
                  Obx(
                    () {
                      return Text(
                        _adminController.lastDate.displayDateMonth(),
                        style: Get.textTheme.subtitle1!.copyWith(
                          color: _themeController.isDarkMode
                              ? kTextColorDark
                              : kTextColorLight,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
