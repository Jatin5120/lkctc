import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/widgets/widgets.dart';

import '../faculty.dart';

class FacultyHomeWrapper extends StatelessWidget {
  const FacultyHomeWrapper({Key? key}) : super(key: key);

  static final NavBarController _navBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (_navBarController.selectedIndex) {
          case 0:
            return const DashboardView();
          case 1:
            return const ClassView();
          case 2:
            return const NotificationView();
          case 3:
            return const SettingsView();
          default:
            return const DashboardView();
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
    );
  }
}
