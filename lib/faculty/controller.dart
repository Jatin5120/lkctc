import 'package:get/get.dart';

class FacultyController extends GetxController {
  final RxBool _hidePassword = true.obs;

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool hidePassword) => _hidePassword.value = hidePassword;
}
