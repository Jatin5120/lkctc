import 'controller.dart';
import 'package:get/get.dart';

class StudentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentController());
  }
}
