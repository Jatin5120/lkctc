import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import 'widgets.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.title,
    this.bottom,
    this.actions,
  }) : super(key: key);

  final String title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  @override
  Size get preferredSize {
    double height = (bottom?.preferredSize.height ?? 0) + 8;
    return Size.fromHeight(kTabBarHeight + height);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Label(title, style: Get.textTheme.headline6),
      bottom: bottom,
      actions: actions,
    );
  }
}
