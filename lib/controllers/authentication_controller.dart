import 'package:get/get.dart';
import '../constants/constants.dart';
import '../controllers/controllers.dart';
import '../faculty/faculty.dart';
import '../routes/routes.dart';
import '../student/student.dart';

class AuthenticationController extends GetxController {
  static final StorageController _storageController = Get.find();

  final RxBool _isLoggedIn = false.obs;
  final RxBool _isLoaded = false.obs;
  final RxInt _selectedIndex = 5.obs;
  final RxString _userType = RxString('');

  @override
  onReady() {
    super.onReady();
    ever(_isLoggedIn, _handleLoggedIn);
    isLoggedIn = _storageController.isUserLoggedIn;
    ever(_isLoaded, _handleLoading);
    userType = _storageController.userType;
  }

  _handleLoading(bool loading) {
    if (loading) {
      Get.offAllNamed(CommonRoutes.auth);
      _handleLoggedIn(isLoggedIn);
    } else {
      Get.offAllNamed(CommonRoutes.splash);
    }
  }

  void _handleLoggedIn(bool loggedIn) {
    if (loggedIn) {
      switch (userType.type) {
        case UserType.admin:
          Get.offAllNamed(AdminRoutes.homeWrapper);
          break;
        case UserType.faculty:
          Get.offAllNamed(FacultyRoutes.homeWrapper);
          break;
        case UserType.student:
          Get.put(StudentController());
          break;
      }
    }
  }

  bool get isLoggedIn => _isLoggedIn.value;
  bool get isLoaded => _isLoaded.value;
  int get selectedIndex => _selectedIndex.value;
  String get userType => _userType.value;

  set isLoggedIn(bool isLoggedIn) => _isLoggedIn.value = isLoggedIn;
  set isLoaded(bool isLoaded) => _isLoaded.value = isLoaded;
  set selectedIndex(int selectedIndex) => _selectedIndex.value = selectedIndex;
  set userType(String userType) => _userType.value = userType;
}
