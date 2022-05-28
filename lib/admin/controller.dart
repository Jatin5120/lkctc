import 'dart:io';

import 'package:get/get.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import '../routes/routes.dart';

class AdminController extends GetxController {
  static final StorageController _storageController = Get.find();
  static final NavBarController _navBarController = Get.find();

  final RxBool _hidePassword = true.obs;
  final RxBool _hideNewPassword = true.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxBool _showError = false.obs;
  final Rx<DateTime> _lastDate = DateTime.now().obs;

  final RxString _error = ''.obs;

  final Rx<File?> _file = Rx<File?>(null);

  @override
  void onReady() {
    super.onReady();
    ever(_isLoggedIn, _handleLogin);
    isLoggedIn = _storageController.isUserLoggedIn;
  }

  void _handleLogin(bool loggedIn) {
    _storageController.writeUserLoggedIn(loggedIn);
    _storageController.writeUserType(UserType.admin.type);

    if (loggedIn) {
      if (Get.currentRoute != AdminRoutes.homeWrapper) {
        Get.offAllNamed(AdminRoutes.homeWrapper);
      }
    } else {
      // Get.offAllNamed(CommonRoutes.auth);
      // Get.toNamed(AdminRoutes.login);
    }
  }

  void logOut() {
    isLoggedIn = false;
    Get.offAllNamed(CommonRoutes.auth);
    Get.toNamed(AdminRoutes.login);
    _navBarController.selectedIndex = 0;
  }

  String get displayeTargetDateMonth => _lastDate.value.displayDateMonth();

  String get fileName => file!.path.split('/').last;

  bool get hidePassword => _hidePassword.value;

  set hidePassword(bool hidePassword) => _hidePassword.value = hidePassword;

  bool get hideNewPassword => _hideNewPassword.value;

  set hideNewPassword(bool hideNewPassword) =>
      _hideNewPassword.value = hideNewPassword;

  bool get isLoggedIn => _isLoggedIn.value;

  set isLoggedIn(bool isLoggedIn) => _isLoggedIn.value = isLoggedIn;

  bool get showError => _showError.value;

  set showError(bool showError) => _showError.value = showError;

  DateTime get lastDate => _lastDate.value;

  set lastDate(DateTime lastDate) => _lastDate.value = lastDate;

  String get error => _error.value;

  set error(String error) => _error.value = error;

  File? get file => _file.value;

  set file(File? file) => _file.value = file;
}
