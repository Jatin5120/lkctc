import 'package:get/get.dart';

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
  ];
}
