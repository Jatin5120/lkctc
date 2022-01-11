import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/modals/faculty_modal.dart';
import 'package:lkctc_student_app/routes/faculty_routes.dart';
import 'package:lkctc_student_app/widgets/label.dart';
import 'package:lkctc_student_app/widgets/tap_handler.dart';

class FacultyNoClassView extends StatelessWidget {
  const FacultyNoClassView({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kScaffoldPadding.copyWith(
            left: 32,
            right: 32,
            top: 32,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Label('Hi, $name', style: Get.textTheme.headline5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  kIllustrationPath + 'no_class.png',
                  width: double.maxFinite,
                  fit: BoxFit.contain,
                ),
              ),
              Label(
                "You’re not currently in a class, try contacting the class teacher of a class to join the class. ",
                style: Get.textTheme.bodyText2,
              ),
              // const SizedBox(height: 16),
              const Spacer(),
              Label(
                "If you’re the class teacher then, create a class by clicking the button below",
                style: Get.textTheme.subtitle1,
              ),
              Row(
                children: [
                  _DottedButton(
                    label: 'Create Class',
                    onTap: () => Get.toNamed(FacultyRoutes.addClass),
                  ),
                  const SizedBox(width: 24),
                  _DottedButton(
                    label: 'Join Class',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DottedButton extends StatelessWidget {
  const _DottedButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (controller) {
        final Color color = controller.isDarkMode ? kWhiteColor : kPrimaryColor;
        return Expanded(
          child: TapHandler(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(
                // horizontal: 16,
                vertical: 32,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 32,
              ),
              decoration: BoxDecoration(
                borderRadius: kLargeRadius,
                border: Border.all(
                  width: 2,
                  color: color,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 0,
                      child: Icon(
                        Icons.add_rounded,
                        color: color,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Label(label, style: Get.textTheme.headline6)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
