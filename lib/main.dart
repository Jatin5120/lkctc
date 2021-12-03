import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lkctc_student_app/authentication/authentication.dart';
import 'package:lkctc_student_app/constants/constants.dart';
import 'package:lkctc_student_app/controllers/controllers.dart';
import 'package:lkctc_student_app/my_screen.dart';
import 'package:lkctc_student_app/routes/routes.dart';
import 'package:lkctc_student_app/test_screen.dart';
import 'package:lkctc_student_app/views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeControllers();
  runApp(const MyApp());
}

Future<void> initializeControllers() async {
  Get.put(ThemeController());
  Get.put(NavBarController());
  Get.put(StorageController());
  Get.put(SplashController());
  Get.put(AuthenticationController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LKCTC Student App',
      debugShowCheckedModeBanner: false,
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      themeMode: themeController.themeMode,
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.pages,
      // home: const AuthenticationView(),
      // home: const SplashView(),
    );
  }
}
