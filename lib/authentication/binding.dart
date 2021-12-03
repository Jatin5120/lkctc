import 'package:lkctc_student_app/authentication/authentication.dart';

import '../controllers/controllers.dart';
import 'package:get/get.dart';

class AuthenticationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => AuthenticationController());
  }
}
