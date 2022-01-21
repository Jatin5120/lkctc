import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/routes/faculty_routes.dart';
import 'package:lkctc_student_app/widgets/app_bar.dart';
import 'package:lkctc_student_app/widgets/tap_handler.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final String subjectID =
              _facultyController.classModal.subjects[index];
          return StreamBuilder(
            stream: FacultyService.getSubject(subjectID),
            builder:
                (_, AsyncSnapshot<DocumentSnapshot<SubjectModal>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Text(snapshot.data!.data()!.name);
            },
          );
        },
      ),
    );
  }
}
