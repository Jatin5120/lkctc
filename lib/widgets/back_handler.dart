import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/services/services.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

class BackHandler extends StatelessWidget {
  const BackHandler({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static final NavBarController _navBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navBarController.selectedIndex != 0) {
          _navBarController.selectedIndex = 0;
          return false;
        } else {
          bool shouldClose = false;
          await DialogService.showConfirmationDialog(
            title: 'Close App?',
            actions: [
              Button.outlined(
                label: 'Exit',
                onTap: () {
                  shouldClose = true;
                },
                buttonColor: kErrorColor,
              ),
              Button(
                label: 'Stay',
                onTap: () {
                  DialogService.closeDialog();
                  shouldClose = false;
                },
              ),
            ],
          );
          return shouldClose;
        }
      },
      child: child,
    );
  }
}
