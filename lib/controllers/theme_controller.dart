import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static const String _themeModeKey = 'themeMode';

  late GetStorage _storage;

  final Rx<ThemeMode> _themeMode = Rx<ThemeMode>(ThemeMode.system);
  final RxBool _isDarkMode = false.obs;
  final RxInt _colorIndex = 0.obs;

  int get colorIndex => _colorIndex.value;
  set colorIndex(int colorIndex) => _colorIndex.value = colorIndex;

  bool get isDarkMode => _isDarkMode.value;
  set isDarkMode(bool isDarkMode) => _isDarkMode.value = isDarkMode;

  ThemeMode get themeMode => _themeMode.value;
  set themeMode(ThemeMode themeMode) => _themeMode.value = themeMode;

  @override
  void onInit() {
    super.onInit();
    _storage = GetStorage();
    ever(_themeMode, handleThemeMode);
    themeMode = _readThemeMode();
  }

  void handleThemeMode(ThemeMode mode) {
    Get.changeThemeMode(mode);
    _writeThemeMode(themeMode);

    switch (themeMode) {
      case ThemeMode.light:
        isDarkMode = false;
        break;
      case ThemeMode.dark:
        isDarkMode = true;
        break;
      case ThemeMode.system:
        Brightness brightness =
            SchedulerBinding.instance!.window.platformBrightness;
        isDarkMode = brightness == Brightness.dark;
        break;
      default:
        isDarkMode = false;
    }
  }

  void _writeThemeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        _storage.write(_themeModeKey, 1);
        break;
      case ThemeMode.dark:
        _storage.write(_themeModeKey, 2);
        break;
      case ThemeMode.system:
        _storage.write(_themeModeKey, 3);
        break;
      default:
    }
  }

  ThemeMode _readThemeMode() {
    int? value = _storage.read(_themeModeKey);
    switch (value) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      case 3:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}
