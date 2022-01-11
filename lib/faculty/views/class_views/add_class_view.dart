import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/services/services.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class FacultyAddClassView extends StatelessWidget {
  const FacultyAddClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Add New Class'),
      body: StreamBuilder<QuerySnapshot>(
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

          final List<FacultyModal> teachers = snapshot.data!.docs
              .map(
                (teacher) => teacher.data() as FacultyModal,
              )
              .toList();
          final TextEditingController _nameController = TextEditingController();
          final TextEditingController _codeController = TextEditingController();

          String teacherValue = teachers.first.name;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: kScaffoldPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DropDown(
                    label: 'Department',
                    items: kDepartments,
                    onChanged: (value) {},
                  ),
                  DropDown(
                    label: 'Semester',
                    items: kSemesters,
                    onChanged: (value) {},
                  ),
                  InputField(
                    label: 'Subjects',
                    hint: 'Subject name',
                    controller: _nameController,
                  ),
                  InputField(
                    hint: 'Subject code',
                    controller: _codeController,
                  ),
                  DropDown<String>(
                    items: teachers.map((faculty) => faculty.name).toList(),
                    hintText: 'Select teacher',
                    value: teacherValue,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  Button(
                    label: 'Add Subject',
                    onTap: () {},
                  ),
                  const _SubjectsList(),
                  const SizedBox(height: 40),
                  Button(
                    label: 'Create Class',
                    buttonSize: ButtonSize.large,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SubjectsList extends StatelessWidget {
  const _SubjectsList({Key? key}) : super(key: key);

  static final FacultyController _facultyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          for (SubjectModal subjectModal in _facultyController.subjects) ...[
            ListTile(
              title: Label(subjectModal.name),
              trailing: IconButton(
                icon: GetBuilder<ThemeController>(builder: (theme) {
                  return Icon(
                    Icons.close_rounded,
                    color: theme.isDarkMode ? kWhiteColor : kBlackColor,
                  );
                }),
                onPressed: () {},
              ),
            )
          ],
        ],
      ),
    );
  }
}
