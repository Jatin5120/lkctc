import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/routes/faculty_routes.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class AllSubjectsView extends StatelessWidget {
  const AllSubjectsView({Key? key}) : super(key: key);

  static final FacultyController _facultyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: '${_facultyController.classModal.name} Subjects',
        actions: [
          TapHandler(
            onTap: () => Get.toNamed(FacultyRoutes.addSubject),
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _facultyController.classModal.subjects.length,
        padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final String subjectID =
              _facultyController.classModal.subjects[index];
          return StreamBuilder(
            stream: FacultyService.subjectStream(subjectID),
            builder:
                (_, AsyncSnapshot<DocumentSnapshot<SubjectModal>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return _SubjectTile(subjectModal: snapshot.data!.data()!);
            },
          );
        },
      ),
    );
  }
}

class _SubjectTile extends StatelessWidget {
  const _SubjectTile({
    Key? key,
    required this.subjectModal,
  }) : super(key: key);

  final SubjectModal subjectModal;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FacultyModal>(
      future: FacultyService.getFaculty(subjectModal.facultyID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final FacultyModal facultyModal = snapshot.data!;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: ListTile(
              trailing: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSubjectColors[subjectModal.colorIndex],
                ),
              ),
              title: Label(subjectModal.name, style: Get.textTheme.bodyText1),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Label(
                      "${facultyModal.designation.shortDesignation} ${facultyModal.name}",
                      style: Get.textTheme.bodyText2,
                    ),
                    const Label('  |  '),
                    Label(subjectModal.subjectCode),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
