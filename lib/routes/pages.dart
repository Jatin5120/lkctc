import 'package:get/get.dart';
import 'package:lkctc_student_app/authentication/authentication.dart';
import 'package:lkctc_student_app/admin/admin.dart';
import 'package:lkctc_student_app/student/student.dart';
import 'package:lkctc_student_app/faculty/faculty.dart';

import '../views/views.dart';
import 'routes.dart';

abstract class AppPages {
  const AppPages._();

  static const String initialRoute = CommonRoutes.splash;

  static final pages = [
    GetPage(
      name: CommonRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: CommonRoutes.auth,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AdminRoutes.login,
      page: () => const AdminLoginView(),
    ),
    GetPage(
      name: StudentRoutes.login,
      page: () => const StudentLoginView(),
    ),
    GetPage(
      name: FacultyRoutes.login,
      page: () => const FacultyLoginView(),
      binding: FacultuBinding(),
    ),
    GetPage(
      name: FacultyRoutes.register,
      page: () => const FacultyRegisterView(),
      binding: FacultuBinding(),
    ),
  ];
}
