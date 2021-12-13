import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';

import 'tap_handler.dart';

class Label extends GetWidget<ThemeController> {
  const Label(this.label, {Key? key, this.style})
      : _textColorLight = kTextColorLight,
        super(key: key);

  const Label.primary(this.label, {Key? key, this.style})
      : _textColorLight = kPrimaryColor,
        super(key: key);

  final String label;
  final TextStyle? style;

  final Color _textColorLight;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style?.copyWith(
        color: controller.isDarkMode ? kTextColorDark : _textColorLight,
      ),
    );
  }
}

class InputLabel extends StatelessWidget {
  const InputLabel(this.label, {Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Label(
        label,
        style: Get.textTheme.subtitle1,
      ),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapHandler(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Label(
              "Already have an account? ",
              style: Get.textTheme.bodyText2,
            ),
            Label(
              'Login',
              style: Get.textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterText extends StatelessWidget {
  const RegisterText({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapHandler(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Label(
              "Don't have an account? ",
              style: Get.textTheme.bodyText2,
            ),
            Label(
              'Register',
              style: Get.textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
