import 'dart:developer';

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

class FacultyAddClassView extends StatefulWidget {
  const FacultyAddClassView({Key? key}) : super(key: key);

  @override
  State<FacultyAddClassView> createState() => _FacultyAddClassViewState();
}

class _FacultyAddClassViewState extends State<FacultyAddClassView> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FacultyController _facultyController = Get.find();

  String? departmentValue;
  String? semesterValue;
  String? inchargeValue;

  void _setClassName() {
    _nameController.text = (departmentValue ?? '') +
        ' ' +
        (semesterValue ?? '') +
        (semesterValue ?? '').ordinalSuffix;
  }

  void _createClass() async {
    if (_formKey.currentState!.validate()) {
      if (departmentValue == null) {
        DialogService.showSnackBar(
          'Department not selected',
          'Kindly choose the respective department to continue',
          dialogType: DialogType.warning,
        );
      } else {
        if (semesterValue == null) {
          DialogService.showSnackBar(
            'Semester not selected',
            'Kindly choose the respective semester to continue',
            dialogType: DialogType.warning,
          );
        } else {
          ClassModal classModal = ClassModal(
            classID: '',
            classInchargeID: _facultyController.faculty.facultyID,
            department: departmentValue!,
            semester: semesterValue!,
            name: _nameController.text,
            faculties: [],
            subjects: [],
            students: [],
            classRepresentatives: [],
            attendanceReferences: [],
          );

          final bool success = await FacultyService.createClass(classModal);

          if (success) {
            Get.back();
          } else {
            DialogService.showErrorDialog(
              title: 'Class not created',
              message:
                  'Unknown error occured while creating the class. Kindly try again after some time',
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: 'Add New Class'),
      body: Padding(
        padding: kScaffoldPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DropDown<String>(
                label: 'Department',
                items: kDepartments,
                value: departmentValue,
                onChanged: (value) {
                  departmentValue = value;
                  _setClassName();
                },
              ),
              DropDown<String>(
                label: 'Semester',
                items: kSemesters,
                value: semesterValue,
                onChanged: (value) {
                  semesterValue = value;
                  _setClassName();
                },
              ),
              InputField(
                label: 'Class Name',
                controller: _nameController,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*Required';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[A-Za-z0-9]+|\s'),
                  ),
                ],
              ),
              const Spacer(),
              Button(
                label: 'Create Class',
                buttonSize: ButtonSize.large,
                onTap: _createClass,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddSubject extends StatefulWidget {
  const _AddSubject({
    Key? key,
    required this.teachers,
  }) : super(key: key);

  final List<FacultyModal> teachers;

  @override
  State<_AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<_AddSubject> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? facultyValue;

  @override
  void initState() {
    super.initState();
  }

  void _addSubject() {
    if (_formKey.currentState!.validate()) {
      print(facultyValue);
      if (facultyValue == null || facultyValue!.isEmpty) {
        DialogService.showSnackBar(
          'Faculty not selected',
          'Kindly select faculty to add subject',
          dialogType: DialogType.warning,
        );
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InputField(
            label: 'Subjects',
            hint: 'Subject name',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Required";
              }
              return null;
            },
          ),
          InputField(
            hint: 'Subject code',
            controller: _codeController,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Required";
              }
              return null;
            },
            inputFormatters: [
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9\-]+')),
            ],
          ),
          DropDown<String>(
            items: widget.teachers.map((faculty) => faculty.name).toList(),
            hintText: 'Select teacher',
            value: facultyValue,
            onChanged: (value) {
              facultyValue = value;
            },
          ),
          const SizedBox(height: 16),
          Button(
            label: 'Add Subject',
            onTap: _addSubject,
          ),
        ],
      ),
    );
  }
}
