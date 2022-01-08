import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/constants.dart';
import 'controllers/controllers.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await GetStorage.init();
  initializeControllers();
  runApp(const MyApp());
}

void initializeControllers() {
  Get.put(ThemeController());
  Get.put(StorageController());
  Get.put(NavBarController());
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
      // home: const TestScreen(),
    );
  }
}
