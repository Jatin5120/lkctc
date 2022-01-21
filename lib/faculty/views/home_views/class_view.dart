import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/colors.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class ClassView extends GetView<FacultyController> {
  const ClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FacultyService.facultyStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Label('No Data'));
        }

        controller.faculty = snapshot.data!.docs.first.data()! as FacultyModal;

        if (controller.faculty.classes.isEmpty) {
          return FacultyNoClassView(
            name: controller.faculty.name,
          );
        }

        return StreamBuilder<DocumentSnapshot<ClassModal>>(
          stream: FacultyService.classStream,
          builder: (context, classSnapshot) {
            if (!classSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            controller.classModal =
                classSnapshot.data!.data() ?? ClassModal.empty();

            return DefaultTabController(
              length: 2,
              child: SafeArea(
                child: Scaffold(
                  appBar: MyAppBar(
                    title: controller.classModal.name,
                    bottom: const MyTabBar(
                      tabs: [
                        Tab(text: 'General'),
                        Tab(text: 'Assignments'),
                      ],
                    ),
                  ),
                  body: const TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      ClassGeneralView(),
                      ClassAssignmentView(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
