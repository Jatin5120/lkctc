// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/modals/modals.dart';
import 'package:lkctc_student_app/routes/routes.dart';

class FacultyController extends GetxController {
  static final StorageController _storageController = Get.find();
  static final NavBarController _navBarController = Get.find();

  final Rx<FacultyModal> _faculty = Rx<FacultyModal>(FacultyModal.empty());

  final RxList<SubjectModal> _subjects = RxList<SubjectModal>.empty();

  final RxBool _isLoggedIn = false.obs;
  final RxBool _hidePassword = true.obs;
  final RxString _facultyID = ''.obs;

  @override
  void onReady() {
    super.onReady();
    ever(_isLoggedIn, _handleLogin);
    ever(_faculty, _handleFacultyID);
    isLoggedIn = _storageController.isUserLoggedIn;
    facultyID = _storageController.facultyID;
    log("facultyID --> $facultyID");
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

  void _handleFacultyID(FacultyModal facultyModal) {
    facultyID = faculty.userID;
    _storageController.writefacultyID(facultyID);
  }

  void logOut() {
    isLoggedIn = false;
    Get.offAllNamed(CommonRoutes.auth);
    Get.toNamed(FacultyRoutes.login);
    _navBarController.selectedIndex = 0;
  }

  FacultyModal get faculty => _faculty.value;

  set faculty(FacultyModal faculty) => _faculty.value = faculty;

  List<SubjectModal> get subjects => _subjects.value;

  set subjects(List<SubjectModal> subjects) => _subjects.value = subjects;

  bool get isLoggedIn => _isLoggedIn.value;

  set isLoggedIn(bool isLoggedIn) => _isLoggedIn.value = isLoggedIn;

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool hidePassword) => _hidePassword.value = hidePassword;

  String get facultyID => _facultyID.value;

  set facultyID(String facultyID) => _facultyID.value = facultyID;
}
