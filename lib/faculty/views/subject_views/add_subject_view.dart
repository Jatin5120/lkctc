import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/services/services.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class AddSubjectView extends StatelessWidget {
  const AddSubjectView({Key? key}) : super(key: key);

  static final ThemeController _themeController = Get.find();
  static final FacultyController _facultyController = Get.find();

  static final TextEditingController _subjectName = TextEditingController();
  static final TextEditingController _subjectCode = TextEditingController();
  static final TextEditingController _link = TextEditingController();

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String getFacultyName(FacultyModal faculty) =>
      "${faculty.designation.shortDesignation} ${faculty.name}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: 'Add Subject'),
      body: StreamBuilder<QuerySnapshot<FacultyModal>>(
        stream: FacultyService.allFacultyStream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            DialogService.showErrorDialog(title: "Can't create Class");
            return Center(
              child: Label(
                'Unable to Create class at the moment',
                style: Get.textTheme.headline6,
              ),
            );
          }
          List<FacultyModal> faculties = [];
          for (QueryDocumentSnapshot<FacultyModal> doc in snapshot.data!.docs) {
            faculties.add(doc.data());
          }

          String? facultyValue;
          return Padding(
            padding: const EdgeInsets.all(16).copyWith(top: 0),
            child: Form(
              key: _formKey,
              child: TapHandler(
                onTap: () => Get.focusScope!.unfocus(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                      label: 'Subjects',
                      hint: 'Subject name',
                      controller: _subjectName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "*Required";
                        }
                        return null;
                      },
                    ),
                    InputField(
                      label: 'Subject Code',
                      hint: 'Subject code',
                      controller: _subjectCode,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "*Required";
                        }
                        return null;
                      },
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Z0-9\-]+')),
                      ],
                    ),
                    DropDown<String>(
                      label: 'Subject Teacher',
                      hintText: 'Select teacher',
                      items: faculties
                          .map((faculty) => getFacultyName(faculty))
                          .toList(),
                      value: facultyValue,
                      onChanged: (value) {
                        facultyValue = value;
                      },
                    ),
                    InputField(
                      label: 'Meeting link',
                      hint: 'Zoom/Google meet link',
                      controller: _link,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.none,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const InputLabel('Subject Color'),
                        TapHandler(
                          onTap: () async {
                            await DialogService.showColorDialog();
                          },
                          child: Obx(
                            () => Card(
                              margin: const EdgeInsets.only(top: 16),
                              elevation: 0,
                              child: Container(
                                height: 32,
                                width: 64,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: kSmallRadius,
                                  color: kSubjectColors[
                                      _themeController.colorIndex],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Button(
                      label: 'Add Subject',
                      buttonSize: ButtonSize.large,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (facultyValue == null || facultyValue!.isEmpty) {
                            DialogService.showSnackBar(
                              'Faculty not selected',
                              'Kindly select faculty to add subject',
                              dialogType: DialogType.warning,
                            );
                          } else {
                            bool addSubject = false;
                            await DialogService.showConfirmationDialog(
                              title: 'Add Subject',
                              description:
                                  "By clicking 'Add' the subject will be added and you won't be able to change data except meeting link",
                              actions: [
                                Button.secondary(
                                  label: 'Let me check',
                                  onTap: () {
                                    addSubject = false;
                                    DialogService.closeDialog();
                                  },
                                ),
                                Button(
                                  label: 'Yes, Add',
                                  onTap: () {
                                    addSubject = true;
                                    DialogService.closeDialog();
                                  },
                                ),
                              ],
                            );

                            if (addSubject) {
                              SubjectModal subjectModal = SubjectModal(
                                subjectID: '',
                                classID: _facultyController.classModal.classID,
                                facultyID: faculties
                                    .where(
                                      (faculty) =>
                                          getFacultyName(faculty) ==
                                          facultyValue,
                                    )
                                    .toList()
                                    .first
                                    .facultyID,
                                name: _subjectName.text,
                                subjectCode: _subjectCode.text,
                                department:
                                    _facultyController.classModal.department,
                                link: _link.text,
                                colorIndex: _themeController.colorIndex,
                              );

                              final bool response =
                                  await FacultyService.createSubject(
                                subjectModal: subjectModal,
                                classModal: _facultyController.classModal,
                              );

                              if (response) {
                                Get.back();
                              }
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
