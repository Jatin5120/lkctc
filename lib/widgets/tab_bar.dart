import 'dart:math';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<Widget> tabs;

  @override
  Size get preferredSize {
    double maxHeight = kTabBarHeight;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: const StadiumBorder(),
      elevation: 0,
      child: TabBar(
        overlayColor:
            MaterialStateColor.resolveWith((states) => kTransparentColor),
        tabs: tabs,
      ),
    );
  }
}
