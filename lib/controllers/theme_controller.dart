import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  static const String _themeModeKey = 'themeMode';
  final Rx<ThemeMode> _themeMode = Rx<ThemeMode>(ThemeMode.system);

  ThemeMode get themeMode => _themeMode.value;

  set themeMode(ThemeMode themeMode) => _themeMode.value = themeMode;

  late GetStorage _storage;

  @override
  void onInit() {
    super.onInit();
    _storage = GetStorage();
    themeMode = _readThemeMode();
  }

  void changeTheme(ThemeMode theme) {
    themeMode = theme;
    Get.changeThemeMode(theme);
    _writeThemeMode(themeMode);
  }

  bool get isDarkMode {
    switch (themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        Brightness brightness =
            SchedulerBinding.instance!.window.platformBrightness;
        return brightness == Brightness.dark;
      default:
        return false;
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
