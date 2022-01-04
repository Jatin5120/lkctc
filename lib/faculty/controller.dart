import 'package:get/get.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';

class FacultyController extends GetxController {
  final RxBool _hidePassword = true.obs;

  final Rx<FacultyModal> _faculty = Rx<FacultyModal>(FacultyModal.empty());

  FacultyModal get faculty => _faculty.value;

  set faculty(FacultyModal faculty) => _faculty.value = faculty;

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool hidePassword) => _hidePassword.value = hidePassword;
}
