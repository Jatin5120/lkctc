import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class NotVerifiedView extends StatelessWidget {
  const NotVerifiedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Label.primary(
                'Account not verified',
                style: Get.textTheme.headline6,
              ),
              const SizedBox(height: 32),
              Label(
                'Your account is not yet verified by the Admin. Kindly contact admin or try again after some time.',
                style: Get.textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
