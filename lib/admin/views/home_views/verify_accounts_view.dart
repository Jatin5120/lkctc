import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/admin/admin.dart';
import 'package:lkctc_student_app/admin/service.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/widgets/button.dart';
import 'package:lkctc_student_app/widgets/label.dart';
import '../../../constants/constants.dart';
import 'package:lkctc_student_app/widgets/app_bar.dart';

class VerifyAccountsView extends StatelessWidget {
  const VerifyAccountsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Verify Accounts'),
      body: StreamBuilder<QuerySnapshot>(
        stream: AdminService.pendingStream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<QueryDocumentSnapshot> accounts = snapshot.data!.docs;

          if (accounts.isEmpty) {
            return const _NoAccounts();
          }
          return ListView.builder(
            itemCount: accounts.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final FacultyModal faculty = FacultyModal.fromMap(
                accounts[index].data() as Map<String, dynamic>,
              );
              return _FacultyCard(faculty);
            },
          );
        },
      ),
    );
  }
}

class _FacultyCard extends StatelessWidget {
  const _FacultyCard(this.faculty, {Key? key}) : super(key: key);

  final FacultyModal faculty;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label(
                      faculty.name,
                      style: Get.textTheme.headline6,
                    ),
                    const SizedBox(height: 4),
                    Label(
                      faculty.email,
                      style: Get.textTheme.subtitle2,
                      lightColor: kCaptionColorLight,
                      darkColor: kCaptionColorDark,
                    ),
                  ],
                ),
                Label(
                  faculty.department,
                  style: Get.textTheme.headline6,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(
                  label: 'Decline',
                  onTap: () => AdminService.rejectingFaculty(faculty),
                  buttonColor: kErrorColor,
                ),
                Button(
                  label: 'Approve',
                  onTap: () => AdminService.acceptFaculty(faculty),
                  buttonColor: kSuccessColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NoAccounts extends StatelessWidget {
  const _NoAccounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No new Faculty accounts to verify at the moment',
        style: Get.textTheme.headline6,
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );
  }
}
