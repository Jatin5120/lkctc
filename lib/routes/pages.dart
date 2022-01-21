import 'package:get/get.dart';
import 'package:lkctc_student_app/faculty/views/subject_views/all_subjects_view.dart';

import 'routes.dart';
import '../bindings/bindings.dart';
import '../admin/admin.dart';
import '../student/student.dart';
import '../faculty/faculty.dart';
import '../views/views.dart';

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
      name: CommonRoutes.changeTheme,
      page: () => const ChangeThemeView(),
    ),
    GetPage(
      name: AdminRoutes.login,
      page: () => const AdminLoginView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: AdminRoutes.homeWrapper,
      page: () => const AdminHomeWrapper(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: AdminRoutes.changePassword,
      page: () => const AdminChangePasswordView(),
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
    GetPage(
      name: FacultyRoutes.homeWrapper,
      page: () => const FacultyHomeWrapper(),
      binding: FacultuBinding(),
    ),
    GetPage(
      name: FacultyRoutes.notVerified,
      page: () => const NotVerifiedView(),
    ),
    GetPage(
      name: FacultyRoutes.addClass,
      page: () => const FacultyAddClassView(),
    ),
    GetPage(
      name: FacultyRoutes.addSubject,
      page: () => const AddSubjectView(),
    ),
    GetPage(
      name: FacultyRoutes.allSubjects,
      page: () => const AllSubjectsView(),
    ),
    GetPage(
      name: StudentRoutes.login,
      page: () => const StudentLoginView(),
    ),
  ];
}
