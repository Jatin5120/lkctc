import 'controller.dart';
import 'package:get/get.dart';

class FacultuBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FacultyController());
  }
}
