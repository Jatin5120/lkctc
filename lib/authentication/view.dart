import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/authentication/authentication.dart';

import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/routes/routes.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class AuthenticationView extends GetWidget<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);

  static const List<_UserTypeModal> _cards = [
    _UserTypeModal(
      label: 'Admin',
      imageUrl: kIllustrationPath + 'admin.png',
      route: AdminRoutes.login,
    ),
    _UserTypeModal(
      label: 'Teacher',
      imageUrl: kIllustrationPath + 'teacher.png',
      route: TeacherRoutes.login,
    ),
    _UserTypeModal(
      label: 'Student',
      imageUrl: kIllustrationPath + 'student.png',
      route: StudentRoutes.login,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width.tenPercent,
                vertical: size.height.fivePercent,
              ).copyWith(top: size.height.tenPercent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.width.thirtyPercent,
                    width: size.width.thirtyPercent,
                    child: const LKCTCLogo(),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Login as',
                    style: Get.textTheme.headline6,
                  ),
                  SizedBox(height: size.height.fivePercent),
                  for (_UserTypeModal _userTypeModal in _cards) ...[
                    _UserTypeCard(
                      modal: _userTypeModal,
                      index: _cards.indexOf(_userTypeModal),
                    ),
                  ],
                  const Spacer(),
                  Obx(
                    () => Button(
                      buttonSize: ButtonSize.large,
                      label: 'Continue',
                      onTap: 0 <= controller.selectedIndex &&
                              controller.selectedIndex <= 2
                          ? () {
                              Get.toNamed(
                                _cards[controller.selectedIndex].route,
                              );
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserTypeCard extends StatelessWidget {
  const _UserTypeCard({
    Key? key,
    required this.modal,
    required this.index,
  }) : super(key: key);

  final _UserTypeModal modal;
  final int index;

  static final ThemeController _themeController = Get.find();
  static final AuthenticationController _authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final bool isSelected =
            _authenticationController.selectedIndex == index;
        return TapHandler(
          onTap: () => _authenticationController.selectedIndex = index,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: kLargeRadius,
              color: _themeController.isDarkMode
                  ? kSecondaryColorDark
                  : kSecondaryColorLight,
              border: isSelected
                  ? Border.all(
                      width: 2,
                      color: _themeController.isDarkMode
                          ? kWhiteColor
                          : kPrimaryColor,
                    )
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(modal.label, style: Get.textTheme.headline5),
                Image.asset(modal.imageUrl),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UserTypeModal {
  final String label;
  final String imageUrl;
  final String route;

  const _UserTypeModal({
    required this.label,
    required this.imageUrl,
    required this.route,
  });
}
