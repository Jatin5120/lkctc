import 'package:flutter/material.dart';
import '../constants/constants.dart';

class TapHandler extends StatelessWidget {
  const TapHandler({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kTransparentColor,
      highlightColor: kTransparentColor,
      onTap: onTap,
      child: child,
    );
  }
}
