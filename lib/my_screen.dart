import 'package:flutter/material.dart';

import 'widgets/bottom_nav_bar.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('My Screen'),
      ),
      bottomNavigationBar: BottomNavBar(
        navBarItems: [
          BottomNavBarItem(icon: Icons.dashboard_rounded),
          BottomNavBarItem(icon: Icons.note_alt_rounded),
          BottomNavBarItem(icon: Icons.calendar_today_rounded),
          BottomNavBarItem(icon: Icons.settings_rounded),
        ],
      ),
    );
  }
}
