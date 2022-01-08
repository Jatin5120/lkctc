import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/colors.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/services/dialog_service.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

import 'home_views/home_views.dart';

class AdminHomeWrapper extends StatelessWidget {
  const AdminHomeWrapper({Key? key}) : super(key: key);

  static final NavBarController _navBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return BackHandler(
      child: Scaffold(
        body: Obx(() {
          switch (_navBarController.selectedIndex) {
            case 0:
              return const VerifyAccountsView();
            case 1:
              return const AddEventsView();
            case 2:
              return const AddNoticesView();
            case 3:
              return const SettingsView();
            default:
              return const VerifyAccountsView();
          }
        }),
        bottomNavigationBar: BottomNavBar(
          navBarItems: [
            BottomNavBarItem(
              icon: Icons.dashboard_rounded,
              onTap: () => _navBarController.selectedIndex = 0,
            ),
            BottomNavBarItem(
              icon: Icons.person_outline_rounded,
              onTap: () => _navBarController.selectedIndex = 1,
            ),
            BottomNavBarItem(
              icon: Icons.notifications_outlined,
              onTap: () => _navBarController.selectedIndex = 2,
            ),
            BottomNavBarItem(
              icon: Icons.settings_outlined,
              onTap: () => _navBarController.selectedIndex = 3,
            ),
          ],
        ),
      ),
    );
  }
}
