import 'package:get/get.dart';
import 'package:lkctc_student_app/routes/routes.dart';

class AuthenticationController extends GetxController {
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isLoaded = false.obs;
  final RxInt _selectedIndex = 5.obs;

  @override
  onReady() {
    super.onReady();
    ever(_isLoaded, handleLoading);
  }

  handleLoading(bool value) {
    if (value) {
      Get.offAllNamed(CommonRoutes.auth);
    } else {
      Get.offAllNamed(CommonRoutes.splash);
    }
  }

  bool get isLoggedIn => _isLoggedIn.value;
  bool get isLoaded => _isLoaded.value;
  int get selectedIndex => _selectedIndex.value;

  set isLoggedIn(bool isLoggedIn) => _isLoggedIn.value = isLoggedIn;
  set isLoaded(bool isLoaded) => _isLoaded.value = isLoaded;
  set selectedIndex(int selectedIndex) => _selectedIndex.value = selectedIndex;
}
