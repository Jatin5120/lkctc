import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'widgets.dart';

PreferredSizeWidget appBar(String title) {
  return AppBar(
    title: Label(title, style: Get.textTheme.headline6),
    centerTitle: true,
    elevation: 0,
    backgroundColor: kTransparentColor,
  );
}
