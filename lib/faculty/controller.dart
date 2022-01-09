import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/routes/common_routes.dart';
import 'package:lkctc_student_app/routes/faculty_routes.dart';

class FacultyController extends GetxController {
  static final StorageController _storageController = Get.find();

  final Rx<FacultyModal> _faculty = Rx<FacultyModal>(FacultyModal.empty());

  final RxBool _isLoggedIn = false.obs;
  final RxBool _hidePassword = true.obs;

  @override
  void onReady() {
    super.onReady();
    ever(_isLoggedIn, _handleLogin);
    isLoggedIn = _storageController.isUserLoggedIn;
  }

  void _handleLogin(bool loggedIn) {
    _storageController.writeUserLoggedIn(loggedIn);
    _storageController.writeUserType(UserType.faculty.type);

    if (loggedIn) {
      Get.offAllNamed(FacultyRoutes.homeWrapper);
    } else {
      // Get.offAllNamed(CommonRoutes.auth);
      // Get.toNamed(FacultyRoutes.login);
    }
  }

  FacultyModal get faculty => _faculty.value;

  set faculty(FacultyModal faculty) => _faculty.value = faculty;

  bool get isLoggedIn => _isLoggedIn.value;

  set isLoggedIn(bool isLoggedIn) => _isLoggedIn.value = isLoggedIn;

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool hidePassword) => _hidePassword.value = hidePassword;
}
