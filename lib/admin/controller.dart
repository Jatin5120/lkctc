import 'dart:io';

import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import '../routes/routes.dart';

class AdminController extends GetxController {
  static final StorageController _storageController = Get.find();

  final RxBool _hidePassword = true.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxBool _showError = false.obs;

  final RxString _error = ''.obs;

  final Rx<File?> _file = Rx<File?>(null);

  bool _didTryLogin = false;

  @override
  void onReady() {
    super.onReady();
    ever(_isLoggedIn, _handleLogin);
    isLoggedIn = _storageController.isUserLoggedIn;
  }

  void _handleLogin(bool loggedIn) {
    if (_didTryLogin) {
      _storageController.writeUserLoggedIn(loggedIn);
      _storageController.writeUserType(UserType.admin.type);
      _didTryLogin = false;

      if (loggedIn) {
        Get.offAllNamed(AdminRoutes.homeWrapper);
      } else {
        // Get.offAllNamed(CommonRoutes.auth);
        // Get.toNamed(AdminRoutes.login);
      }
    }
  }

  void logIn() {
    _didTryLogin = true;
    isLoggedIn = true;
  }

  void logOut() {
    _didTryLogin = true;
    isLoggedIn = false;
    Get.offAllNamed(CommonRoutes.auth);
    Get.toNamed(AdminRoutes.login);
  }

  String get fileName => file!.path.split('/').last;

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool hidePassword) => _hidePassword.value = hidePassword;

  bool get isLoggedIn => _isLoggedIn.value;

  set isLoggedIn(bool isLoggedIn) => _isLoggedIn.value = isLoggedIn;

  bool get showError => _showError.value;

  set showError(bool showError) => _showError.value = showError;

  String get error => _error.value;

  set error(String error) => _error.value = error;

  File? get file => _file.value;

  set file(File? file) => _file.value = file;
}
