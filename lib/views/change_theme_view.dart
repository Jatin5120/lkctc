import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/extensions.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class ChangeThemeView extends StatelessWidget {
  const ChangeThemeView({Key? key}) : super(key: key);

  static final List<String> _themes = [
    ThemeMode.light.string(),
    ThemeMode.dark.string(),
    ThemeMode.system.string(),
  ];

  static final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Change Theme'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            DropDown<String>(
              label: 'Choose Theme',
              items: _themes,
              value: _themeController.themeMode.string(),
              onChanged: (themeMode) =>
                  _themeController.themeMode = themeMode!.toTheme,
            ),
          ],
        ),
      ),
    );
  }
}
