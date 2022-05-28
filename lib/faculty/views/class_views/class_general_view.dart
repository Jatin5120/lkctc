import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/routes/routes.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class ClassGeneralView extends StatelessWidget {
  const ClassGeneralView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _FacultyName(),
          const _BuildSubjects(),
        ],
      ),
    );
  }
}

class _FacultyName extends StatelessWidget {
  const _FacultyName({Key? key}) : super(key: key);

  static final FacultyController _facultyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 32,
            child: FlutterLogo(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Label(
                _facultyController.faculty.name,
                style: Get.textTheme.headline6,
              ),
              Label('Class Incharge', style: Get.textTheme.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildSubjects extends StatelessWidget {
  const _BuildSubjects({Key? key}) : super(key: key);

  static final FacultyController _facultyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Label('Subjects', style: Get.textTheme.bodyText1),
              if (_facultyController.classModal.subjects.isNotEmpty) ...[
                TapHandler(
                  onTap: () => Get.toNamed(FacultyRoutes.allSubjects),
                  child: const Label.primary('See all'),
                ),
              ],
            ],
          ),
        ),
        if (_facultyController.classModal.subjects.isEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Label('No subjects added'),
              Button(
                label: 'Subject',
                icon: Icons.add_rounded,
                buttonSize: ButtonSize.small,
                onTap: () {
                  Get.toNamed(FacultyRoutes.addSubject);
                },
              ),
            ],
          ),
        ] else ...[
          SizedBox(
            height: 64,
            child: ListView.builder(
              itemCount: _facultyController.classModal.subjects.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final String subjectID =
                    _facultyController.classModal.subjects[index];
                return StreamBuilder(
                  stream: FacultyService.subjectStream(subjectID),
                  builder: (_,
                      AsyncSnapshot<DocumentSnapshot<SubjectModal>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return _SubjectCard(
                      subjectModal: snapshot.data!.data()!,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}

class _SubjectCard extends StatelessWidget {
  const _SubjectCard({
    Key? key,
    required this.subjectModal,
  }) : super(key: key);

  final SubjectModal subjectModal;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: kSubjectColors[subjectModal.colorIndex],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          child: Text(
            subjectModal.name.shortSubjectName,
            style: Get.textTheme.headline6!.copyWith(color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}
