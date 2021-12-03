import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isLoaded = false.obs;

  @override
  onReady() {
    super.onReady();
    ever(_isLoaded, handleLoading);
  }

  handleLoading(bool value) {}

  bool get isLoggedIn => _isLoggedIn.value;
  bool get isLoaded => _isLoaded.value;

  set isLoggedIn(bool isLoggedIn) => _isLoggedIn.value = isLoggedIn;
  set isLoaded(bool isLoaded) => _isLoaded.value = isLoaded;
}
