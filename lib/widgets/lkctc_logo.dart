import 'package:flutter/material.dart';
import 'package:lkctc_student_app/constants/constants.dart';

class LKCTCLogo extends StatelessWidget {
  const LKCTCLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(kLogoPath + 'lkctc.png');
  }
}
