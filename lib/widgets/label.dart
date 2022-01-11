import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';

import 'tap_handler.dart';

class Label extends StatelessWidget {
  const Label(
    this.label, {
    Key? key,
    this.style,
    this.textAlign,
    this.lightColor,
    this.darkColor,
  })  : _textColorLight = lightColor ?? kTextColorLight,
        _textColorDark = darkColor ?? kTextColorDark,
        super(key: key);

  const Label.primary(
    this.label, {
    Key? key,
    this.style,
    this.textAlign,
    this.lightColor,
    this.darkColor,
  })  : _textColorLight = lightColor ?? kPrimaryColor,
        _textColorDark = darkColor ?? kTextColorDark,
        super(key: key);

  final String label;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Color? lightColor;
  final Color? darkColor;

  final Color _textColorLight;
  final Color _textColorDark;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (controller) {
      return Text(
        label,
        style: style?.copyWith(
          color: controller.isDarkMode ? _textColorDark : _textColorLight,
        ),
        textAlign: textAlign,
        softWrap: true,
      );
    });
  }
}

class InputLabel extends StatelessWidget {
  const InputLabel(this.label, {Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
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
